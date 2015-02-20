From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] cpu-model/s390: Add processor
 property routines
Date: Fri, 20 Feb 2015 17:05:38 +0100
Message-ID: <20150220170538.7ab9e5ae@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73EB2.6050700@suse.de>
	<20150220163209.4e082e0b@bee>
	<54E755BD.5000705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <54E755BD.5000705@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 16:41:49 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> Also a general comment: cpu-model/ is not an existing directory nor o=
ne
> you add, so please use "target-s390x: Add foo to S390CPU" or so.

I will address this with v3, thanks a lot for the hint, I never saw thi=
s as directories though...

Michael
