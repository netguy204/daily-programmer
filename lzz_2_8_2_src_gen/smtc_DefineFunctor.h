// smtc_DefineFunctor.h
//

#ifndef LZZ_smtc_DefineFunctor_h
#define LZZ_smtc_DefineFunctor_h
// semantic
#include "smtc_BaseSpecPtrVector.h"
#include "smtc_ClassKey.h"
#include "smtc_CvType.h"
#include "smtc_NamePtr.h"
#include "smtc_ParamPtrVector.h"
#include "smtc_ScopePtr.h"
#include "smtc_ThrowSpecPtr.h"
#include "smtc_TryBlockPtr.h"

// gram
#include "gram_SpecSel.h"
#include "gram_Block.h"
#define LZZ_INLINE inline
namespace smtc
{
  void defineFunctor (ScopePtr const & scope, gram::SpecSel const & spec_sel, CvType const & ret_type, NamePtr const & name, ParamPtrVector const & ctor_param_set, bool ctor_vararg, ParamPtrVector const & call_param_set, bool call_vararg, Cv const & cv, ThrowSpecPtr const & throw_spec, BaseSpecPtrVector const & base_spec_set, gram::Block const & body, TryBlockPtr const & try_block);
}
#undef LZZ_INLINE
#endif
