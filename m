Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 23 Jan 2019 14:24:01 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
References: <20190123125513.20210-1-labbott@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190123125513.20210-1-labbott@redhat.com>
Message-Id: <20190123132401.GG3424@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>, Andreas Krebbel <krebbel@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
> There's a build failure with gcc9:
> 
>  ./arch/s390/include/asm/jump_label.h: Assembler messages:
>  ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
>  ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
>  make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
> 
> According to the toolchain people, the actual issue is the use of
> "X" constraint which is too permissive. Switch to using "i" instead.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1668703
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/s390/include/asm/jump_label.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
> index e2d3e6c43395..41dabfd8518d 100644
> --- a/arch/s390/include/asm/jump_label.h
> +++ b/arch/s390/include/asm/jump_label.h
> @@ -22,7 +22,7 @@ static inline bool arch_static_branch(struct static_key *key, bool branch)
>  			  ".long	0b-.,%l[label]-.\n"
>  			  ".quad	%0-.\n"
>  			  ".popsection\n"
> -			  : : "X" (&((char *)key)[branch]) : : label);
> +			  : : "i" (&((char *)key)[branch]) : : label);
>  	return false;
>  label:
>  	return true;

Hmmm, this works only for the kernel image, but not for modules, which
we compile with "-fPIC", which again doesn't work as described in the
referenced bugzilla:

In file included from ././include/linux/compiler_types.h:68,
                 from <command-line>:
./arch/s390/include/asm/jump_label.h: In function 'kvm_vcpu_ioctl':
./include/linux/compiler-gcc.h:124:38: warning: asm operand 0 probably doesn't match constraints
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
  ^~~~~~~~~~~~~~~~~
./include/linux/compiler-gcc.h:124:38: error: impossible constraint in 'asm'
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"

Andreas, Ilya, any idea how to fix this?
