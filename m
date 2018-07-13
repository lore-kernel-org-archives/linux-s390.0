From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Fri, 13 Jul 2018 15:15:06 +0000
Subject: Livepatch consistency model, objtool, and s390x arch
Message-Id: <a4bc4c46-0a0e-1ac1-c2f6-6f6903ac992d@redhat.com>
To: linux-s390@vger.kernel.org, live-patching@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi folks,

With Josh's input, I've been looking at the s390x architecture with
respect to the livepatch consistency model and whether we will need to
port objtool to ensure stack frame correctness.

Background on livepatch's consistency model can be found in
Documentation/livepatch/livepatch.txt and objtool's compile-time stack
metadata validation in tools/objtool/Documentation/stack-validation.txt

Using the following s390x references:

  zSeries ELF Application Binary Interface Supplement
  http://refspecs.linuxfoundation.org/ELF/zSeries/lzsabi0_zSeries.pdf

  Enterprise Systems Architecture/390: Principles of Operation
  http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/download/DZ9AR008.pdf

I wrote a tool using objdump and awk [1] that matches various s390x
stack usage patterns across an entire v4.16 'allyesconfig' and
CONFIG_COMPILE_TEST kernel build.  The tool runs a simple heuristic
that reports functions that branch without having allocating stack or
copy/pushed a backchain pointer beforehand.

After scanning ~250000 functions, the objdump+awk tool reported only 23
"interesting" functions (see the 'report' file in the github[1] page).
I've attempted to filter out as many irrelevant functions/object files
as possible (see the 'loop' script), but I suspect that the remaining
23 functions may be false-positives.  Pattern matching improvements or
assembly explanations welcome :)

While the zSeries ELF Application Binary Interface Supplement talks
about setting up stack frames:

  The stack frame

  A function will be passed a frame on the runtime stack by the
  function which called it, and may allocate a new stack frame. A new
  stack frame is required if the called function will in turn call
  further functions (which must be passed the address of the new frame).

I didn't see anything inherent to the architecture that enforces this
convention.  In other words, unlike say x86, I don't think s390x's
calling/return instructions imply anything about the stack. That would
mean it should be possible to craft strange s390x assembly code that
brasl's its way functions deep without setting a backpointer (perhaps
using registers to remember the call chain).

That said, according to the objdump+awk report, it doesn't look like
there is much non-standard s390 stack usage present in the kernel tree,
even in the hand-coded assembly files.

My take is that existing code is generally compliant in setting up
stack frames, but one /could/ bend over backwards to avoid them.
However, I'm not an s390x expert, so I figured I would share these
thoughts and the objdump+awk tool results with those far more
knowledgeable about the architecture and problem space.

[1] https://github.com/joe-lawrence/s390x-objtool

-- Joe
