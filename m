Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ms11p00im-qufo17281401.me.com ([17.58.38.51]:54761 "EHLO
        ms11p00im-qufo17281401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729335AbgEEPDR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 11:03:17 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
From: Qian Cai <cailca@icloud.com>
In-Reply-To: <a9dcc2b8-15a5-73ff-5784-46c61c8eb2b8@de.ibm.com>
Date: Tue, 5 May 2020 11:03:12 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D5D39B5-B4FE-4371-A8D3-A03D7CC78C2F@icloud.com>
References: <20200505083515.2720-1-borntraeger@de.ibm.com>
 <a9dcc2b8-15a5-73ff-5784-46c61c8eb2b8@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>



> On May 5, 2020, at 5:15 AM, Christian Borntraeger =
<borntraeger@de.ibm.com> wrote:

> applied for kvms390/master.
>=20
> Qian Cai, can you verify that this fixes the issue?

Thank you for tracking it down and removed the warning, so there is no =
way for me to trigger it anymore. Otherwise, my simple test case works =
fine for z/VM nested KVM here.
