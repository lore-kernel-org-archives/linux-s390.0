From: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC PATCH v2 0/7] s390: virtual css host support.
Date: Wed, 05 Sep 2012 10:51:25 +0300
Message-ID: <5047047D.7000406@redhat.com>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 09/04/2012 06:13 PM, Cornelia Huck wrote:
> Hi,
> 
> here's the second revision of the virtual channel subsystem support for
> s390.
> 
> I changed the representation of the channel subsystem, introducing channel
> subsystem images, which brings it closer to the actual implementation. A
> new ioctl for adding a new channel subsystem image has also been introduced.

Looks good to me, though of course I could only do a shallow review.

I'd like to see acks from an s390 maintainer on the non-kvm patches, and
will apply after the other comments are addressed.


-- 
error compiling committee.c: too many arguments to function
