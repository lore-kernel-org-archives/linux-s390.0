From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: asm-geniric: for atomic_set_mask() 1st param, use
 'unsigned int' instead of 'unsigned long'
Date: Thu, 13 Jun 2013 09:47:26 +0800
Message-ID: <51B924AE.40103@asianux.com>
References: <51B2E262.3030603@asianux.com> <CAErSpo5pg0EvJOR9nn3B0d+q0o6zsdwzM41AQx=AHfynRqX3hQ@mail.gmail.com> <51B3DFCF.1010509@asianux.com> <CAErSpo57_4SnE0_UwNvRc-M2+JvHmpiYTpQE2rAFUXuBEopvFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo57_4SnE0_UwNvRc-M2+JvHmpiYTpQE2rAFUXuBEopvFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mike Frysinger <vapier@gentoo.org>, takata@linux-m32r.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, realmz paranoid <realmz6@gmail.com>, linux390@de.ibm.com, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/11/2013 01:00 AM, Bjorn Helgaas wrote:
> On Sat, Jun 8, 2013 at 7:52 PM, Chen Gang <gang.chen@asianux.com> wrote:
>> > On 06/09/2013 01:49 AM, Bjorn Helgaas wrote:
>>> >> s/geniric/generic/ in subject
>>> >>
>> >
>> > Could you provide more details information ?
> In your subject line, "geniric" is spelled incorrectly.  The correct
> spelling is "generic."
> 
> 

Thanks.

-- 
Chen Gang

Asianux Corporation
