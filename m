From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/5] s390: Virtual channel subsystem support.
Date: Wed, 8 Aug 2012 20:34:45 +0100
Message-ID: <CAFEAcA-MOySg2FTGxcq=c6GUXhrsiukAi=yTHTv6GHt6AzfB0g@mail.gmail.com>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351173-2716-3-git-send-email-cornelia.huck@de.ibm.com>
	<CAAu8pHt=yf2oh4PQ8RwxkR5-mXp_EOMqAQ9pq+w54peXk_+H-g@mail.gmail.com>
	<20120808101750.35800579@BR9GNB5Z>
	<CAAu8pHs2Y99uEADxRUXgLbh47R-SW2wbQy3JiYuniFFdFWv+KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAAu8pHs2Y99uEADxRUXgLbh47R-SW2wbQy3JiYuniFFdFWv+KQ@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Sebastian Ott <sebott@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 8 August 2012 20:16, Blue Swirl <blauwirbel@gmail.com> wrote:
> On Wed, Aug 8, 2012 at 8:17 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>> On Tue, 7 Aug 2012 21:00:59 +0000
>> Blue Swirl <blauwirbel@gmail.com> wrote:
>>> Please use more descriptive names instead of acronyms, for example SubChStatus.
>>
>> I'd rather leave these at the well-known scsw, pmcw, etc. names. These
>> have been around for decades, and somebody familiar with channel I/O
>> will instantly know what a struct scsw is, but will need to look hard
>> at the code to figure out the meaning of SubChStatus.
>
> If they are well-known and have been around for so long time, are
> there any suitable header files (with compatible licenses) where they
> are defined which could be reused?
>
> Otherwise, please follow CODING_STYLE.

I think we should follow CODING_STYLE for capitalisation issues
but generally if the device's documentation has standard abbreviations
for register names, structures, etc, etc we should use them. Often
this code has to be maintained later by somebody else who might not
be familiar with the general operation of the hardware and who is trying
to match up the code with whatever the data sheet says. Following the
naming used in the h/w docs makes that job easier.

(for instance I took the opportunity of making a bunch of structure
member names in target-arm line up with the ARM ARM names
as part of the refactoring that went on a while back.)

-- PMM
