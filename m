From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 05/14] x86: Use set_memory.h header
Date: Thu, 2 Mar 2017 09:01:26 +0100
Message-ID: <20170302080126.GA9574@gmail.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-6-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1488413706-9739-6-git-send-email-labbott@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Takashi Iwai <tiwai@suse.com>, Wim Van Sebroeck <wim@iguana.be>, "H. Peter Anvin" <hpa@zytor.com>, linux-watchdog@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.>
List-ID: <linux-s390.vger.kernel.org>


* Laura Abbott <labbott@redhat.com> wrote:

> 
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/x86/kernel/amd_gart_64.c      | 2 +-
>  arch/x86/kernel/cpu/amd.c          | 2 +-
>  arch/x86/kernel/cpu/bugs.c         | 2 +-
>  arch/x86/kernel/ftrace.c           | 2 +-
>  arch/x86/kernel/machine_kexec_64.c | 1 +
>  arch/x86/mm/init.c                 | 2 +-
>  arch/x86/mm/init_64.c              | 2 +-
>  arch/x86/mm/ioremap.c              | 2 +-
>  arch/x86/mm/pageattr.c             | 1 +
>  arch/x86/net/bpf_jit_comp.c        | 1 +
>  arch/x86/pci/pcbios.c              | 2 +-
>  arch/x86/platform/efi/efi.c        | 2 +-
>  arch/x86/realmode/init.c           | 2 +-
>  13 files changed, 13 insertions(+), 10 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
