From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: asm-generic: for atomic_set_mask() 1st param,
 use 'unsigned int' instead of 'unsigned long'
Date: Thu, 13 Jun 2013 09:19:46 +0800
Message-ID: <51B91E32.2040502@asianux.com>
References: <51B2E262.3030603@asianux.com> <CAErSpo5pg0EvJOR9nn3B0d+q0o6zsdwzM41AQx=AHfynRqX3hQ@mail.gmail.com> <51B4214E.6090007@asianux.com> <20130610092106.GA4697@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20130610092106.GA4697@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mike Frysinger <vapier@gentoo.org>, takata@linux-m32r.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, realmz paranoid <realmz6@gmail.com>, linux390@de.ibm.com, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Marc Gauthier <Marc.Gauthier@tensilica.com>
List-ID: <linux-s390.vger.kernel.org>

On 06/10/2013 05:21 PM, Heiko Carstens wrote:
> On Sun, Jun 09, 2013 at 02:31:42PM +0800, Chen Gang wrote:
>> > 
>> > atomic_set_mask() and atomic_clear_mask() are the pairs, so the related
>> > parameters' type need match with each other.
>> > 
>> > The type of 'addr->counter' is 'int', so use 'unsigned int' instead
>> > of 'unsigned long', and let atomic_set_mask() match atomic_clear_mask().
>> > 
>> > 
>> > For arch sub-system, currently, have 3 types of definition for them:
>> > 1st for 'int', 2nd for 'long', 3rd is conflict to use 'int' and 'long'.
>> > 
>> > At least, better to fix 3rd (conflict using 'int' and 'long').
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  arch/blackfin/include/asm/atomic.h |    4 ++--
>> >  arch/m32r/include/asm/atomic.h     |    8 ++++----
>> >  arch/s390/include/asm/atomic.h     |    4 ++--
>> >  include/asm-generic/atomic.h       |    2 +-
>> >  4 files changed, 9 insertions(+), 9 deletions(-)
> For the s390 part:
> 
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 

Thank you very much !!


-- 
Chen Gang

Asianux Corporation
