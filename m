From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH v2 7/7] s390/kvm: In-kernel channel subsystem support.
Date: Wed, 19 Sep 2012 17:57:26 +0300
Message-ID: <5059DD56.2000909@redhat.com>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com> <1346771610-52423-8-git-send-email-cornelia.huck@de.ibm.com> <48430489-B96F-4717-AA1E-B04445F55717@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <48430489-B96F-4717-AA1E-B04445F55717@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 09/19/2012 05:47 PM, Alexander Graf wrote:
> 
> On 04.09.2012, at 17:13, Cornelia Huck wrote:
> 
>> Handle most support for channel I/O instructions in the kernel itself.
>> 
>> Only asynchronous functions (such as the start function) need to be
>> handled by userspace.
> 
> Phew. This is a lot of code for something that is usually handled in user space in the kvm world. The x86 equivalent would be an in-kernel PCI bus, right? Have you measured major performance penalties when running this from user space?
> 
> Avi, what do you think?

I know nothing of this stuff.  But your request for numbers is justified
of course.



-- 
error compiling committee.c: too many arguments to function
