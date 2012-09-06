From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] virtio-spec: Add virtio-ccw spec.
Date: Fri, 07 Sep 2012 09:27:59 +0930
Message-ID: <87oblihfg8.fsf@rustcorp.com.au>
References: <1346771641-12136-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771641-12136-2-git-send-email-cornelia.huck@de.ibm.com>
	<87ehmfj38o.fsf@rustcorp.com.au> <20120906155147.56e08f10@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20120906155147.56e08f10@BR9GNB5Z>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Cornelia Huck <cornelia.huck@de.ibm.com> writes:

> On Thu, 06 Sep 2012 11:56:31 +0930
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
>> 
>> > Add specifications for the new s390 specific virtio-ccw transport.
>> >
>> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> 
>> Excellent.  I have applied and pushed this revision.
>
> Cool.
>
> Unfortunately, we just discovered that we probably need to expand the
> protocol to allow for a configuration-changed marker in addition to the
> indicator bits. Can we easily amend the spec later on?

Hmm, I'll delay the point-release of the spec until I have that patch.

You can amend the spec because you're the only implementation, but it's
poor form :)

Cheers,
Rusty.
