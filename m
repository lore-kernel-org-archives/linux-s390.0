From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECK
Date: Wed, 27 Feb 2013 14:56:09 -0800
Message-ID: <512E8F09.2090003@linux.intel.com>
References: <1361934016-22630-1-git-send-email-sboyd@codeaurora.org> <201302272032.21014.arnd@arndb.de> <512E6FA9.4060504@codeaurora.org> <512E8664.3070903@zytor.com> <20130228094510.3341017130e4476e046bdd22@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20130228094510.3341017130e4476e046bdd22@canb.auug.org.au>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Stephen Boyd <sboyd@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chris Metcalf <cmetcalf@tilera.com>
List-ID: <linux-s390.vger.kernel.org>

On 2/27/2013 2:45 PM, Stephen Rothwell wrote:
> Hi all,
>
> On Wed, 27 Feb 2013 14:19:16 -0800 "H. Peter Anvin" <hpa@zytor.com> wrote:
>>
>> Although some of the cases I have seen being flagged as "false
>> positives" have been real bugs.
>
> [hijacking the thread :-)]
>
> I have been getting this warning for a very long time ( which would be an
> error if CONFIG_DEBUG_STRICT_USER_COPY_CHECK was set):
>
> i386 defconfig
> i386-linux-gcc (GCC) 4.6.3
>
> In file included from arch/x86/include/asm/uaccess.h:537:0,
>                   from include/linux/uaccess.h:5,
>                   from include/linux/highmem.h:8,
>                   from include/linux/pagemap.h:10,
>                   from fs/binfmt_misc.c:27:
> arch/x86/include/asm/uaccess_32.h: In function 'parse_command.part.2':
> arch/x86/include/asm/uaccess_32.h:211:26: warning: call to 'copy_from_user_overflow' declared with attribute warning: copy_from_user() buffer size is not provably correct [enabled by default]
>


http://gcc.gnu.org/bugzilla/show_bug.cgi?id=35392

the gcc folks finally fixed that one it seems

(but while there are some false positives, esp with older gcc, the majority were real originally.. just those all got fixed)
