From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCHv2 03/14] arm64: Use set_memory.h header
Date: Thu, 2 Mar 2017 15:06:19 +0000
Message-ID: <20170302150618.GD12157@e104818-lin.cambridge.arm.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-4-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488413706-9739-4-git-send-email-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Takashi Iwai <tiwai@suse.com>, Wim Van Sebroeck <wim@iguana.be>, "H. Peter Anvin" <hpa@zytor.com>, linux-watchdog@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 01, 2017 at 04:14:55PM -0800, Laura Abbott wrote:
> The set_memory_* functions have moved to set_memory.h. Use that header
> explicitly.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
