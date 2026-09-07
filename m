Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5A39478B
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809053; cv=none; b=IHklxkWaJ6chKfYEzaiOBmcNKNaGgZpQjrFqAcP+t71Oi/PCL3txxGSirFs5d7e5C8gMjKTlKfaRzanygdZKhamFQ2T5lvgWGLGTyf7odZqNhpu9I1SqCf86Q7MJkgDy13NmX35VVg+ARx5DEwLGYyQpEhu69DrJQXbPa030NMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809053; c=relaxed/simple;
	bh=0QaHieNOw6KcvnOUUn3YC2pxzyaljxv036GAwc2TNyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMXUqM5SWO6Kqt98MqXFlXKC/huP8xNAacp5/Il4qAniwhXq11J0MEq1mEUQeQBkdYMDlZvHts4zlkR/if6dW0tfFA+gwsHJpYXciu1T8zYHNwNgP8y23KiZAyPfgbwu3vz98cuWrUGK9yerWhtTbfcxDEvsSLvuG1F7DE410JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2533d83e3bso654407966b.2
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 12:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788809049; x=1789413849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7+PGqvd3SIvPbBZ74nQwLWteKLtMN7893g76P/jiAU=;
        b=s42iI0w1lP2mpgctY4X1HpBVTVw1Af2ekc21pECl8KXBxh1Pr+mAATh2PY6Dxw4Hgm
         cBdV/ubelLxxiHHYgXjmLmuvTk4yQHtKVXUq4CSSVh/lAj/QrkJnzlrSk8Zk0uph1rzk
         KFfyZKXVqeE9tJJQ8f4XXTP0P8k+YDZjlMPamkGJEUVbjySr8kGJP3c/G16LnKVCXXrX
         DGtEVkHXlT/W2fJoj4pZ8fEjzJxU2b/I3JREV0uGu2tkKzEDrHKfMRUrk+pFZaDHQPeS
         6UQhwa0V5ENWiS+z/uzWdwmCG4GJNaRLviQTXCqlxs8qwy758YQmcVIVQPquai/PyG8L
         VABQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlnn9lqfBLcQLpj54Ui9uG+N6NeKtvjS6wekKnTW3zUBdR+2GV1+3C3B/HEdWI5YcSGrRayc4lFZwG@vger.kernel.org
X-Gm-Message-State: AFuF++kTggOXWiPhkl1tpGih4rrQG75UM77rY6NjYpxu156YI4AQyCMq
	bciCBxduKleiOMcWNTvGkKzaBRNCqDUi7U5+i6AvaYpK5vN7IP7vm8Q7UondWxEOm9Y=
X-Gm-Gg: AYBFou16b0P4SFRQTJ+Kli5o1Zu0aipFjrbebokdETeq++F71PDh5Da/iKOpNyziq9M
	/hiyj252T0+hbjuFOLj/LKabSiBrGsAFVq7JoFquteszCTw/8cZr02WsqO35/ShdBWGyLZrH/v3
	89nDOIkp3brih1KROtgsYKy4Mmqr8dPHKBmSUsJ4uQcveBEp2S8xzqgaXVYbzggXaw7OyhnaAZv
	qsiGTFe8a689dmClZ9IHRPCawDuV23SL1AuISvqfet8UcvJpXaZyBVO6YDH0qZIBOsju6MH5Vhr
	Pc6FEI3byznqyteUcUSM9oULvb87PylC9GBbscgGBVJKe3ldA6yXuJiZ2RuDWPxLbSejLh1GPie
	7sIRS4tzgTw7AF7guvOMECzKSBmLeU+QNp2yJ/96BCKT+rT3VGJJagIYrnOIvwAo65LrXkscep0
	nifhpkoibW46z98kBGVXJ5sTKrAGe5INQnqr4+5ARp6GROuPgsiKvuqBEjadDV+rCmoTg7iAU7X
	tX3J6a2rGQdNG15hM+iIRcq8o4FlG5umZMfvC0SE1lDRkuFI9Pz0z2PtA==
X-Received: by 2002:a17:907:c64a:20b0:c25:c979:e76a with SMTP id a640c23a62f3a-c262b88e613mr770883366b.22.1788809049223;
        Mon, 07 Sep 2026 12:24:09 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b371esm510517566b.54.2026.09.07.12.24.09
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 12:24:09 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c252c7270faso554066066b.3
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 12:24:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUmMVzRIUyrnSNAKAWY0jN6cEdAe7E3Vws0tcAnx95VYVVL4eJq6EH4gY3ryKbe93ELpoTY5JsnvXj@vger.kernel.org
X-Received: by 2002:a17:906:7953:b0:c25:5114:c832 with SMTP id
 a640c23a62f3a-c260c971f07mr1826536466b.3.1788808679899; Mon, 07 Sep 2026
 12:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
From: Fangrui Song <i@maskray.me>
Date: Mon, 7 Sep 2026 12:17:48 -0700
X-Gmail-Original-Message-ID: <CAN30aBFo-1v+igPmm2JEqOBVuywxMD7HPVcxf+OQSd8LBnZYaQ@mail.gmail.com>
X-Gm-Features: AcwNN1Ui_dhr8zWhdtT8d8B1cx26oY95n-5s0YmX52J9IMUYBxLn9nwqemexDEs
Message-ID: <CAN30aBFo-1v+igPmm2JEqOBVuywxMD7HPVcxf+OQSd8LBnZYaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/24] unwind_user: Implement .eh_frame handling
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, 
	Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 12:53=E2=80=AFPM Jens Remus <jremus@linux.ibm.com> =
wrote:
>
> This series adds support for parsing DWARF Call Frame Information (CFI)
> from the .eh_frame_hdr and .eh_frame sections of user space ELF files.
>
> The code is based on the deferred unwind user work originally done for
> SFrame by Josh, Steven, and myself:
>
>   v4 : https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.o=
rg/
>   v10: https://lore.kernel.org/all/20250827201548.448472904@kernel.org/
>   v16: https://lore.kernel.org/all/20260521142546.3908498-1-jremus@linux.=
ibm.com/
>
> The goal is to make user space stack traces available in-kernel without
> requiring frame pointers and without copying large parts of the user
> stack for later processing.
>
> Today, reliable user stack traces from the kernel generally requires
> frame pointers.  Otherwise, profilers such as perf have to copy large
> amounts of user space stack into the kernel ring buffer and process it
> later.  Frame pointers are simple and robust, but enabling them for
> all executables and libraries has a performance cost.
>
> Another issue is that the frame layout can vary between compilers and
> architectures, and on architectures such as s390 there is no defined
> frame layout which allows reliable frame-pointer based stack tracing.
> The only way to perform user space profiling on there architectures is
> to copy the user space into the kernel buffer.
>
>
> The .eh_frame section is already emitted by most toolchains on most
> architectures unless explicitly disabled.  It contains DWARF CFI
> describing how to recover the caller state at any point in a function.
> The .eh_frame_hdr section provides a binary search table for looking
> up the Frame Description Entry (FDE) for a given instruction pointer
> (IP).
>
> Because the .eh_frame_hdr and .eh_frame sections live in the ELF file,
> they need to be faulted in when used.  This means that walking the user
> space stack requires being in a faultable context.  As profilers like
> perf request a stack trace in interrupt or NMI context, the walking
> cannot be done when requested.  This series reuses the deferred unwind
> user framework, that performed the actual user stack trace is later in
> a faultable context, before the task returns to user space.
>
> This series implements .eh_frame[_hdr] support for the deferred unwind
> user code and enables it for x86-64 and s390.
>
> It intentionally not implement a complete DWARF unwinder.  It evaluates
> only the subset of DWARF CFI needed for stack tracing:
>
>   - Call Frame Address (CFA):  Using rule from DWARF CFI.
>
>   - Stack pointer (SP):  Using an implicit rule based on the CFA
>     definition (SP =3D CFA for most architectures).
>
>   - Frame pointer (FP):  Using rule from DWARF CFI.
>
>   - Return address (RA):  Using rule from DWARF CFI.
>
> Unsupported CFI instructions, unsupported expressions, invalid data, or
> user memory faults stop the stack tracing safely and results in a partial
> stack trace.
>
>
> This series applies on top of v7.2 tag:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  v7.2
>
> The to be stack-traced user space executables and libraries need to
> contain .eh_frame_hdr and .eh_frame sections as well as a GNU_EH_FRAME
> PHDR.
>
> Namhyung Kim's related perf tools deferred callchain support can be used
> for testing, for example:
>
>   perf record --call-graph fp,defer ...
>   perf report
>   perf script
>
>
> Why .eh_frame?
>
> This series is not meant to replace or undermine the SFrame work.
> SFrame remains the simpler and more purpose-built format for user stack
> tracing.  The motivation for .eh_frame support is pragmatic:  .eh_frame
> is already widely deployed today.
>
> - Availability and maturity:  .eh_frame is already present in most ELF
>   binaries for C++ exception handling.  It has been used in production
>   for decades for exception handling and debugger stack unwinding.
>
> - Toolchain support:  .eh_frame is supported across all major compilers
>   and architectures today, whereas .sframe adoption is still emerging.
>
> - Size:  .sframe would be added in addition to existing .eh_frame[_hdr]
>   rather than replacing it, increasing the ELF file size. [1]
>
>
> Addressing historical DWARF concerns:
>
> Using DWARF for kernel unwinding has a bad history.  Previous attempts
> were complex, fragile, slow, and hard to maintain.  Hand-written
> assembly and the complexity of the DWARF state machine were among the
> reasons the simpler ORC kernel unwind format was developed. [2,3,4]
>
> However, this implementation for user space stack tracing differs from
> those problematic kernel unwinding attempts:
>
> - It stack traces user space, not kernel.
>
> - It runs in a deferred, faultable context, not in NMI, interrupt, or
>   oops context.
>
> - It may return partial stack traces.  Bad CFI, unsupported operations,
>   invalid user memory, or faults are allowed to terminate the unwind.
>
> - It implements only the CFI subset needed for stack tracing, not a
>   general DWARF unwinder.
>
> - It does not include a general-purpose DWARF expression VM.  Expression
>   size is bounded.  Only a small number of pattern-matched expressions
>   is supported (e.g. DRAP and PLT expressions on x86).  Unsupported
>   expressions cause stack tracing to fail safely.
>
> - All user memory access uses [unsafe_]get_user() with proper bounds
>   checking and fault handling.
>
> - Corruption detection with automatic section removal on invalid
>   .eh_frame prevents further stack tracing attempts.
>
>
> Limitations and future work:
>
> - CIE version 1 support only and no DWARF64 support, as I have not run
>   into either during my testing.
>
> - Signal frames are not handled yet.  An architecture hook could support
>   unwinding through FDEs whose CIE augmentation contains 'S' (signal
>   frame), similar to Glibc's SFrame backtrace() support.  See also my
>   "[RFC PATCH v1 0/5] s390: Signal frame user space unwinding". [5]
>
> - x86-32, x86-x32, and 32-bit compat mode support not implemented yet.
>
> - CIE caching would be useful.  Reading an FDE requires reading its
>   referenced CIE first to obtain the FDE encoding.  Most .eh_frame
>   sections have only a very small number of CIEs, often one default
>   CIE shared by most FDEs and possibly one signal frame CIE.  Caching
>   the last CIE per section, together with the initial CFA, FP, and RA
>   rules, would avoid repeated CIE parsing and initial CFI instruction
>   processing.
>
>
> [1]: https://lore.kernel.org/all/CAN30aBFVDxeoXApn_g_Hw0Ayhi4V=3Dm7CcX8UD=
O6ZDTi6xA-3Pg@mail.gmail.com/
> [2]: https://lwn.net/Articles/727553/
> [3]: https://lkml.org/lkml/2012/2/10/356
> [4]: https://lkml.org/lkml/2017/5/20/165
> [5]: https://lore.kernel.org/all/20260127153331.2902504-1-jremus@linux.ib=
m.com/
>
>
> Patches 1-6 add base functionality to unwind user to support .eh_frame-
> based (or .sframe-based) unwinding.  Patches originate from my latest
> .sframe patch series.
>
> Patches 7-10 add the basic infrastructure for reading .eh_frame_hdr and
> .eh_frame sections and storing them in a per-mm maple tree.
>
> Patches 11-14 wire up the eh_frame infrastructure to the unwind user
> framework and add error handling and debugging support.
>
> Patch 15 duplicates registered .eh_frame_hdr section data on clone/fork.
>
> Patch 16 improves .eh_frame DWARF CFI instruction processing.
>
> Patch 17 enables architectures to implement selected DWARF expressions
> in CFI instructions.
>
> Patches 18-21 enable .eh_frame unwinding on x86-64 with minimal DWARF
> expression support for DRAP and PLT expressions.
>
> Patches 22-23 enable .eh_frame unwinding on s390.
>
> Patch 24 adds a prctl() interface for (un)registering .eh_frame_hdr
> sections for shared libraries.  I will send a related test-patch for
> Glibc separately.
>
>
> Changes in RFC v2:
> - Addressed most of Sashikos AI review feedback.
> - Dropped patch that added support for linear .eh_frame search, as
>   there is no good mean to limit it from reading outside of the
>   .eh_frame section.
> - Tweaked limits based on limited testing (still fairly arbitrary;
>   needs more thought):
>   - Reduced state stack depth limit to 1.
>   - Added FDE length limit of 32.768 bytes.
>   - Added CFI instruction limit (CIE+FDE) of 16.384 instructions.
>
>
> Note that I will be away from keyboard for two weeks.  I'll reply
> to your (and Sashiko AI's) feedback afterwards.
>
>
> Thanks and regards,
> Jens

Thanks for pivoting to .eh_frame unwinding. This work is highly appreciated=
.

The moment deferred unwinding is implemented, the kernel space
objection (https://lwn.net/Articles/728339/) no longer applies.
Every argument for ORC (and derived formats like SFrame) -- that it
must not crash during crash handling, that it is simple enough to be
bug-free, and that it is fast enough for lockdep -- was formulated
specifically to justify that kernel execution path.

On the userspace side, we are seeing major advances in compact unwinding:

* x86-64 (Alexis Engelke): Implemented a compact-unwind encoder in lld
that encodes 100% of Clang (main) -O3 and 99.9% of GCC 15 -O3
functions in an -fno-exceptions libLLVM.so. This reduces .eh_frame_hdr
+ .eh_frame size by 87% for Clang (1.80 descriptors per FDE) and 71%
for GCC (3.85 descriptors per FDE).
https://conf.gnu-tools-cauldron.org/prg26/talk/review/WV7MVNYXJA8XSMKRVBBV9=
GQJZZ3LW9KT
* AArch64 (Shoaib): Implemented a corresponding compact-unwind encoder
for AArch64, used in Android apps.

Crucially, neither of these approaches generates unwind information in
relocatable files.
Given the massive size reductions achieved by these compact unwind
descriptors, I suspect there won't be a use case or remaining need for
.sframe on either AArch64 or x86-64.
