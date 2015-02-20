From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] cpu-model/s390: Add processor
 property routines
Date: Fri, 20 Feb 2015 17:53:21 +0100
Message-ID: <20150220175321.63fc8e3a@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73EB2.6050700@suse.de>
	<20150220163209.4e082e0b@bee>
	<54E755BD.5000705@suse.de>
	<20150220170408.49db6da5@bee>
	<54E7609E.6020302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E7609E.6020302@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 17:28:14 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

Andreas,

> Sorry for my ignorance, but what is proc actually needed for? For
> initializing the class, there's .class_init (and cc->fac_list apparen=
tly
> is initialized here). If you need to pass info to KVM, you can do so =
in

yes, it is communication to the accelerator to prepare its local cpu mo=
del related data
structures which are used to initialize a vcpu (e.g. the facility list =
beside others)=20

> DeviceClass::realize when the vCPU actually goes "live". A

I will look what "goes live" in detail means here, it should at least b=
e before
kvm_arch_vcpu_setup() gets triggered on accelerator side.

> string-to-string (or string-to-ObjectClass) translation function seem=
s
> like a weird point in time to take action with global effect.
>=20
> Anyway, please implement the generic callback, then you can still cal=
l
> it from your own helper functions if needed.

Thanks a lot!
Michael
