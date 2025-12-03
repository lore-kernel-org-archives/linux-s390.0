Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACD350D7B;
	Wed,  3 Dec 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778491; cv=none; b=qoLbTbluA/aEouD+8iWuh7Hmj+7CK3KM/d8s1oZJz6pE9lgoPM56eDQ225VEjn93WBja6OvLm2ZzpRqbg8Htee437oxxgHGHDwi0bLzBoTG9mNUbgskebOsHOgJEXL43/aJTrvLGViw8knzumv8WsSj9MNDlJ7XjM6Rcx6bnKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778491; c=relaxed/simple;
	bh=z6VTVaJYZuYGiOA7w0UAwal0DllxIWPefT/BoTs8k8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRdivKeTiNEVn8G9O5P1Q+CxYXqZl4dhPqzS1sZ+G1O/TbpJ+8A7rNSfZi+0cBYt+kN3sPhyitE6ygVaJm43+8jlxR9xC27KdYASDpa+IwNLshlw6Di9yuxhhgz6QpV74DF04GwxleUXPRN8IfPULss/tH5wHrYFR55rxg1UuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SGdHUgLW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SGdHUgLW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3DQ7q2018611;
	Wed, 3 Dec 2025 16:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I1XcFX
	dkOjeoULkvauJKxjNq3gYThXJVuJH/tGuPNjU=; b=SGdHUgLWrI5FAVWTAWHEA/
	p69VvhMlO2HA/5mSiYYCePPti3ITaRMYlZYkkhoskvHuiLYCyQxVEBlNd3NtdhSM
	H5DBhpOI/ESITOFZvlpttiyMYtBNMqqDL+NsdDiPRFGPSCVpPix+wcmwK0h3DX+l
	cK+Ea7MCfQ+bv8zY87FhW/DukocQPveGDSksrtum5ZPGyNdb2ZbJeAegUq69bwhD
	ujKbSljsF+MD7gYQhaMkzspGNjb86oHVwka2gqdqiGCTUHOJbeHbrC4z5XDIpWB7
	KbPKaCNwJ8Vx92zapiw29cQXbUtTcUG9V+FSTFJ6kdRPyFzDfo0SffLCSvBOfqrQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q3e5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 16:14:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3Dkdqq029343;
	Wed, 3 Dec 2025 16:14:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1jqs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 16:14:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3GEeuI29229562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 16:14:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C6802004B;
	Wed,  3 Dec 2025 16:14:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB4F820043;
	Wed,  3 Dec 2025 16:14:39 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 16:14:39 +0000 (GMT)
Message-ID: <0506645063efd6c1472c3b787b5195e96e18048e.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas
 Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Halil Pasic	 <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner	
 <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Farhan Ali
	 <alifm@linux.ibm.com>
Date: Wed, 03 Dec 2025 17:14:39 +0100
In-Reply-To: <20251203-implement-msi-domain-v8-2-94836907490b@linux.ibm.com>
References: <20251203-implement-msi-domain-v8-0-94836907490b@linux.ibm.com>
	 <20251203-implement-msi-domain-v8-2-94836907490b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfXxiiRke+EOHli
 c9DIHaqNXg6XeHOa1t0WHdD6houKBtsoPjn4c6tNVV/dl/Ja7IbPUOIu2rtjJS1k/kw/IE3CoLW
 djz9lnlgmbyNHfE5V2PbOPpJTOKBSKIDbDdtotep3FH8jsdmM4gaQtHW5hUuZXvA34AQfqpc//g
 2AJTv6SDmPF08fV/4N9hk7kfvlq86AlNnDlqHnaHalcl0NZHVfaW4KcrpaRICpGsKefJ3tl5GJ5
 lBka2Kb3F+eTZPBCtqNeVyIPpLjBOluoaObpFzjSFssY21CgboPsl7+qLqSnH+DRnjhHNfl//RR
 Pij9X5ZoclYCan6mTm2qp84YA6Mysz2pWBCzUjTuKDHBqYUC0y3YQA673Zk75+jrb2JbqST2+gS
 JpsV1v+3Rru8ojt8R11Ojy8E95ztYQ==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=693061f4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=GtYmHFm1981V0wC81xkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Lejmrq425iCyu3IuwnGHqZi2IBqVhQv4
X-Proofpoint-GUID: Lejmrq425iCyu3IuwnGHqZi2IBqVhQv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

On Wed, 2025-12-03 at 15:36 +0100, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>=20
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>=20

  [ ... snip ... ]

> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int=
 virq,
> +				 unsigned int nr_irqs)
> +{
> +	struct zpci_dev *zdev;
> +	struct msi_desc *desc;
> +	struct irq_data *d;
> +	unsigned long bit;
> +	unsigned int cpu;
> +	u16 msi_index;
> +	int i;
> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		d =3D irq_domain_get_irq_data(domain, virq + i);
> +		msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
> +		desc =3D irq_data_get_msi_desc(d);
> +		zdev =3D to_zpci_dev(desc->dev);
> +		bit =3D zdev->msi_first_bit + msi_index;
> =20
> +		if (irq_delivery =3D=3D DIRECTED) {
>  			for_each_possible_cpu(cpu) {
> -				for (i =3D 0; i < irqs_per_msi; i++)
> -					airq_iv_set_data(zpci_ibv[cpu],
> -							 hwirq + i, irq + i);
> +				airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
> +				airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
>  			}
>  		} else {
> -			msg.address_lo =3D zdev->msi_addr & 0xffffffff;
> -			for (i =3D 0; i < irqs_per_msi; i++)
> -				airq_iv_set_data(zdev->aibv, hwirq + i, irq + i);
> +			airq_iv_set_ptr(zdev->aibv, bit + i, 0);
> +			airq_iv_set_data(zdev->aibv, bit + i, 0);
>  		}
> -		msg.address_hi =3D zdev->msi_addr >> 32;
> -		pci_write_msi_msg(irq, &msg);
> -		hwirq +=3D irqs_per_msi;
> +
> +		irq_domain_reset_irq_data(d);
>  	}
> +}=20

Thanks for addressing my concern about clearing the airq data!

FWIW, what you thing about abstracting out the airq clearing stuff with
something like this diff on top, so the loop body remains somewhat
short and zpci_msi_domain_free() keeps its working set of local
variables.


diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 5639789dc58f..3322d8c9aff1 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -439,34 +439,37 @@ static int zpci_msi_domain_alloc(struct
irq_domain *domain, unsigned int virq,
        return 0;
 }
=20
-static void zpci_msi_domain_free(struct irq_domain *domain, unsigned
int virq,
-                                unsigned int nr_irqs)
+static void zpci_msi_clear_airq(struct irq_data *d, int i)
 {
-       struct zpci_dev *zdev;
-       struct msi_desc *desc;
-       struct irq_data *d;
+       struct msi_desc *desc =3D irq_data_get_msi_desc(d);
+       struct zpci_dev *zdev =3D to_zpci_dev(desc->dev);
        unsigned long bit;
        unsigned int cpu;
        u16 msi_index;
-       int i;
=20
-       for (i =3D 0; i < nr_irqs; i++) {
-               d =3D irq_domain_get_irq_data(domain, virq + i);
-               msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
-               desc =3D irq_data_get_msi_desc(d);
-               zdev =3D to_zpci_dev(desc->dev);
-               bit =3D zdev->msi_first_bit + msi_index;
+       msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
+       bit =3D zdev->msi_first_bit + msi_index;
=20
-               if (irq_delivery =3D=3D DIRECTED) {
-                       for_each_possible_cpu(cpu) {
-                               airq_iv_set_ptr(zpci_ibv[cpu], bit + i,
0);
-                               airq_iv_set_data(zpci_ibv[cpu], bit +
i, 0);
-                       }
-               } else {
-                       airq_iv_set_ptr(zdev->aibv, bit + i, 0);
-                       airq_iv_set_data(zdev->aibv, bit + i, 0);
+       if (irq_delivery =3D=3D DIRECTED) {
+               for_each_possible_cpu(cpu) {
+                       airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
+                       airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
                }
+       } else {
+               airq_iv_set_ptr(zdev->aibv, bit + i, 0);
+               airq_iv_set_data(zdev->aibv, bit + i, 0);
+       }
+}
=20
+static void zpci_msi_domain_free(struct irq_domain *domain, unsigned
int virq,
+                                unsigned int nr_irqs)
+{
+       struct irq_data *d;
+       int i;
+
+       for (i =3D 0; i < nr_irqs; i++) {
+               d =3D irq_domain_get_irq_data(domain, virq + i);
+               zpci_msi_clear_airq(d, i);
                irq_domain_reset_irq_data(d);
        }
 }

Sorry for me keeping nagging...
Gerd
