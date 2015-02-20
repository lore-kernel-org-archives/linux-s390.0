From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [Qemu-devel] [RFC PATCH v2 10/15] cpu-model/s390: Add cpu class
 initialization routines
Date: Fri, 20 Feb 2015 17:34:28 +0100
Message-ID: <54E76214.6080100@suse.de>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>	<1424183053-4310-11-git-send-email-mimu@linux.vnet.ibm.com>	<54E75AA2.9070503@twiddle.net> <20150220171249.210a0236@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220171249.210a0236@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, frank.blaschka@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Am 20.02.2015 um 17:12 schrieb Michael Mueller:
> On Fri, 20 Feb 2015 08:02:42 -0800
> Richard Henderson <rth@twiddle.net> wrote:
>=20
>>> +/**
>>> + * s390_test_facility - test if given facility bit is set facility=
 list
>>> + *                      of given cpu class
>>> + * @class: address of cpu class to test
>>> + * @nr: bit number to test
>>> + *
>>> + * Returns: true in case it is set
>>> + *          false in case it is not set
>>> + */

Please note that QEMU uses gtk-doc style, where the description goes
between arguments and Returns:, and the function name gets a ':'.
There's also fancy syntax like #CPUClass, %true, etc.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N=FCrnberg)
