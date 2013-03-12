From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-s390: document GPR4/GPR2 cookie values
Date: Tue, 12 Mar 2013 14:17:48 +1030
Message-ID: <87y5dtuvmj.fsf@rustcorp.com.au>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<20130226110421.GB10915@redhat.com>
	<20130226111812.GA11111@redhat.com>
	<20130307180221.GA30580@redhat.com>
	<20130308085548.5bba025d@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130308085548.5bba025d@gondolin>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> On Thu, 7 Mar 2013 20:02:21 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> virtio-s390 on kvm can use a cookie value passed to guest
>
> s/virtio-s390/virtio-ccw/ (to avoid confusion with s390-virtio, which
> was never specced)
>
>> to optimize channel/VQ lookups.
>> Document this.
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Otherwise:
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>
> Rusty, could you please apply?

Modified and committed.

Thanks!
Rusty.
