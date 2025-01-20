Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C911B6D01;
	Mon, 20 Jan 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367689; cv=none; b=pqgEDiBEujGXNvQU+3i5TuK3ZC8Kr8u40goXa9NxOqFaspNgIujEaDS02sW4koYSB4IospoKHn5cvwiN9E8S9HY0S40UiK8GZwqmZsKyVfpSdcSHWMmYc4odYdEouOXFGn6bxQixzlh8xqG/EONzF/tA3CfMNAfk6+DWYkutH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367689; c=relaxed/simple;
	bh=3QIK0LeCkSSJJ6MZXDbBEv7lStjLSLrPLzCM6fCxnXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Pp8q0+S+LtkcRA58NRguEuGCq4wWV54OBSouWS32KFD+7ObLQa03k29farkx/Y/MwWhr9x7hrjJotzRWQbRE/XFBII1Ke7z7Mz1BmGZJKM8n7ow5R75sDK7jvz2kQPMC26FJ0yEy3Kz6n9SPJuP06FB6PJTuoMRjG0r0J3hHxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cR6ju4AO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cR6ju4AO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K20haK031849;
	Mon, 20 Jan 2025 10:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mbvKmJ
	O2LGWVHPAlJeFO/UU7/ZG2FqSeMx6toZf0+gA=; b=cR6ju4AOM+CADOdDlkjQ0Y
	l4ymDVbI614mVXyftYQ+eagsjEWMjOZA82lMBQq9NG4EWh2FZYpRt5fbqjKEYIYu
	/jc43K2WmV/+j45wfjHSufFFoXEzflFk+1xOLwvStvBp3C5zzEcAQ610iIGpYwMz
	4XAY6ogMUSRBX1VGytHn0q+pntbXtDrxXpJeYanl919M5wXbaz9kAZNnxlP8LeBR
	zvcBuyQV+0YoDYkkbF18lscgJLtd3YZR/rh9L0C9cyuiwI0y+Ui8oPdbzrHDRJup
	szmVq3NCkmncAF/sTxL0poQTDpfsC/qMAHrPTsKzljyHZHfevSquqQ1krLVeluxA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449db0sv4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:07:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50KA7xS4022322;
	Mon, 20 Jan 2025 10:07:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449db0sv4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:07:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K97PHt032248;
	Mon, 20 Jan 2025 10:07:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujdhsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:07:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KA7t6U22217014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:07:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBDAF20065;
	Mon, 20 Jan 2025 10:07:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B53120063;
	Mon, 20 Jan 2025 10:07:54 +0000 (GMT)
Received: from localhost (unknown [9.152.212.252])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 10:07:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jan 2025 11:07:54 +0100
Message-Id: <D76TFVAMAGCP.2BN616RUY7GOY@linux.ibm.com>
Cc: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Thorsten Winkler"
 <twinkler@linux.ibm.com>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily
 Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Simon Horman" <horms@kernel.org>
Subject: Re: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism
 functions
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Alexandra Winter" <wintera@linux.ibm.com>, <dust.li@linux.alibaba.com>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        "Jan Karcher" <jaka@linux.ibm.com>,
        "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        "Tony Lu"
 <tonylu@linux.alibaba.com>,
        "Wen Gu" <guwen@linux.alibaba.com>,
        "Peter
 Oberparleiter" <oberpar@linux.ibm.com>,
        "David Miller"
 <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Andrew Lunn"
 <andrew+netdev@lunn.ch>
X-Mailer: aerc 0.18.2
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-5-wintera@linux.ibm.com>
 <20250120063241.GM89233@linux.alibaba.com>
 <aba18690-5ffb-4eee-8931-728d72ce90c3@linux.ibm.com>
In-Reply-To: <aba18690-5ffb-4eee-8931-728d72ce90c3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bVZhpNZg5IeAKcNkE0Ln76m1MySoqTDO
X-Proofpoint-GUID: cMT6SfS517poCO48ex2R2MymIyjOGOrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=986 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200083

On Mon Jan 20, 2025 at 10:56 AM CET, Alexandra Winter wrote:
>
>
> On 20.01.25 07:32, Dust Li wrote:
> >> +	/**
> >> +	 * move_data() - write into a remote dmb
> >> +	 * @dev: Local sending ism device
> >> +	 * @dmb_tok: Token of the remote dmb
> >> +	 * @idx: signalling index
> >> +	 * @sf: signalling flag;
> >> +	 *      if true, idx will be turned on at target ism interrupt mask
> >> +	 *      and target device will be signalled, if required.
> >> +	 * @offset: offset within target dmb
> >> +	 * @data: pointer to data to be sent
> >> +	 * @size: length of data to be sent
> >> +	 *
> >> +	 * Use dev to write data of size at offset into a remote dmb
> >> +	 * identified by dmb_tok. Data is moved synchronously, *data can
> >> +	 * be freed when this function returns.
> > When considering the API, I found this comment may be incorrect.
> >=20
> > IIUC, in copy mode for PCI ISM devices, the CPU only tells the
> > device to perform a DMA copy. As a result, when this function returns,
> > the device may not have completed the DMA copy.
> >=20
>
> No, it is actually one of the properties of ISM vPCI that the data is
> moved synchronously inside the move_data() function. (on PCI layer the
> data is moved inside the __zpci_store_block() command).
> Obviously for loopback move_data() is also synchornous.

That is true for the IBM ISM vPCI device but maybe we
should design the API also for future PCI devices
that do not move data synchronously.

>
> SMC-D does not make use of it, instead they re-use the same
> conn->sndbuf_desc for the lifetime of a connection.
>
>
> > In zero-copy mode for loopback, the source and destination share the
> > same buffer. If the source rewrites the buffer, the destination may
> > encounter corrupted data. The source should only reuse the data after
> > the destination has finished reading it.
> >=20
>
> That is true independent of the question, whether the move is
> synchronous or not.
> It is the clients' responsibility to make sure a sender does not
> overwrite unread data. SMC uses the write-pointers and read-pointer for
> that.
>
>
> > Best regards,
> > Dust
> >=20
> >> +	 *
> >> +	 * If signalling flag (sf) is true, bit number idx bit will be
> >> +	 * turned on in the ism signalling mask, that belongs to the
> >> +	 * target dmb, and handle_irq() of the ism client that owns this
> >> +	 * dmb will be called, if required. The target device may chose to
> >> +	 * coalesce multiple signalling triggers.
> >> +	 */
> >> 	int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
> >> 			 bool sf, unsigned int offset, void *data,
> >> 			 unsigned int size);
> >> --=20

