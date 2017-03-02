From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCHv2 00/14] set_memory_* functions header refactor
Date: Thu, 2 Mar 2017 08:34:26 +0100
Message-ID: <20170302073426.GA7265@osiris>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, "H. Peter Anvin" <hpa@zytor.com>, linux-watchdog@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 01, 2017 at 04:14:52PM -0800, Laura Abbott wrote:
> Hi,
> 
> This is v2 of my proposal to move set_memory_* function prototypes out of
> cacheflush.h and into their own header file. This came out of a comment
> Russell made while reviewing RODATA test cases
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480855.html
> While the final result of that series was the rodata code was refactored into
> its own header file, the set_memory_* APIs are still out of place.
> 
> This version refactored the common set_memory_* functions into an asm-generic
> header. s390x added some features so it can't just use the asm-generic header.
> I debated how much more to try and shove into the asm-generic version (e.g.
> stub prototypes for the ARM nommu case, set_kernel_text_*) but decided to stick
> with just the basics for this version.
> 
> I split out the cacheflush.h -> set_memory.h conversions into separate patches
> to hopefully make merging easier. Worst case, the final patch to completely
> separate the two can be delayed if there are more problems found. I'd like
> for this to eventually go through the -mm tree so I'd like Acks where
> appropriate.
> 
> As always, feedback appreciated.

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
