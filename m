From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/5] kvm: Make ioeventfd usable on s390.
Date: Tue, 26 Feb 2013 14:48:38 +0100
Message-ID: <512CBD36.6080003@de.ibm.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<20130226110421.GB10915@redhat.com>
	<20130226111812.GA11111@redhat.com> <512CA6F3.7080203@de.ibm.com>
	<20130226134156.GA11665@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130226134156.GA11665@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On 26/02/13 14:41, Michael S. Tsirkin wrote:
>> So...
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> So let's apply the patch for 3.9 and

Give us 1 or 2 days testing for regression and then this can go for 3.9.
The host changes can then be deferred to a later point in time.

> avoid caring about "old guests" much?

Well caring about old guests is related to caring about malicious guests.
Maybe we should make it explicit in the spec that the token can be wrong
or omitted. Just to avoid that anybody starts to optimize things too
aggressive. 

Ok?

Christian
