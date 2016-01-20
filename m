Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] support for text-relative kallsyms table
Date: Wed, 20 Jan 2016 12:50:52 +0100
Message-ID: <50119924.p1gpv2Aolf@wuerfel>
In-Reply-To: <20160120103325.GA20197@gmail.com>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160120103325.GA20197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: linuxppc-dev@lists.ozlabs.org
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, mmarek@suse.cz, linux-s390@vger.kernel.org, rusty@rustcorp.com.au, keescook@chromium.org, x86@kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hpa@zytor.com, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 20 January 2016 11:33:25 Ingo Molnar wrote:
> > The reduction ranges from around 250 KB uncompressed vmlinux size and 10 KB 
> > compressed size (s390) to 3 MB/500 KB for ppc64 (although, in the latter case, 
> > the reduction in uncompressed size is primarily __init data)
> 
> So since kallsyms is in unswappable kernel RAM, the uncompressed size reduction is 
> what we care about mostly. How much bootloader load times are impacted is a third 
> order concern.
> 
> IOW a nice change!

I think some people care a lot about the compressed size as well:

http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/generic/patches-4.4/203-kallsyms_uncompressed.patch;h=cf8a447bbcd5b1621d4edc36a69fe0ad384fe53f;hb=HEAD

This has been in openwrt.git for ages, because a lot of the target devices
are much more limited on flash memory size (4MB typically) than they are
on RAM size (at least 32MB).

	Arnd
