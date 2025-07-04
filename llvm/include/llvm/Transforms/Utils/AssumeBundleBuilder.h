//===- AssumeBundleBuilder.h - utils to build assume bundles ----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contain tools to preserve informations. They should be used before
// performing a transformation that may move and delete instructions as those
// transformation may destroy or worsen information that can be derived from the
// IR.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TRANSFORMS_UTILS_ASSUMEBUNDLEBUILDER_H
#define LLVM_TRANSFORMS_UTILS_ASSUMEBUNDLEBUILDER_H

#include "llvm/Analysis/AssumeBundleQueries.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Compiler.h"

namespace llvm {
class AssumeInst;
class Function;
class Instruction;
class AssumptionCache;
class DominatorTree;

LLVM_ABI extern cl::opt<bool> EnableKnowledgeRetention;

/// Build a call to llvm.assume to preserve informations that can be derived
/// from the given instruction.
/// If no information derived from \p I, this call returns null.
/// The returned instruction is not inserted anywhere.
LLVM_ABI AssumeInst *buildAssumeFromInst(Instruction *I);

/// Calls BuildAssumeFromInst and if the resulting llvm.assume is valid insert
/// if before I. This is usually what need to be done to salvage the knowledge
/// contained in the instruction I.
/// The AssumptionCache must be provided if it is available or the cache may
/// become silently be invalid.
/// The DominatorTree can optionally be provided to enable cross-block
/// reasoning.
/// This returns if a change was made.
LLVM_ABI bool salvageKnowledge(Instruction *I, AssumptionCache *AC = nullptr,
                               DominatorTree *DT = nullptr);

/// Build and return a new assume created from the provided knowledge
/// if the knowledge in the assume is fully redundant this will return nullptr
LLVM_ABI AssumeInst *
buildAssumeFromKnowledge(ArrayRef<RetainedKnowledge> Knowledge,
                         Instruction *CtxI, AssumptionCache *AC = nullptr,
                         DominatorTree *DT = nullptr);

/// This pass attempts to minimize the number of assume without loosing any
/// information.
struct AssumeSimplifyPass : public PassInfoMixin<AssumeSimplifyPass> {
  LLVM_ABI PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

/// This pass will try to build an llvm.assume for every instruction in the
/// function. Its main purpose is testing.
struct AssumeBuilderPass : public PassInfoMixin<AssumeBuilderPass> {
  LLVM_ABI PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

/// canonicalize the RetainedKnowledge RK. it is assumed that RK is part of
/// Assume. This will return an empty RetainedKnowledge if the knowledge is
/// useless.
LLVM_ABI RetainedKnowledge simplifyRetainedKnowledge(AssumeInst *Assume,
                                                     RetainedKnowledge RK,
                                                     AssumptionCache *AC,
                                                     DominatorTree *DT);

} // namespace llvm

#endif
