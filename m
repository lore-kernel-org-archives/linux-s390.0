Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885C1AB507;
	Thu, 30 Jan 2025 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738237055; cv=none; b=sdnS0lgj3uVOSKkeTcIwp7Gb97jrutwzV1u6SsGrVO2eGqe2g/zkW1l6fQ1EoCl900zlZ/TymS9u4X+kVv3+ouU4Bme5ZXLx9O2gFSnsPaHAl4re3M5GBiQxZSCXMxhvUGOKkfCd7Ui5u8jffmCntdY7OFx3cFwBqCIRgYOBGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738237055; c=relaxed/simple;
	bh=eNEifiQlJ4jJCEH5dTNUFgbaF6ZAfBjKUry/CKfo1A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyGOj4Lwu00Exuia95PwVx9IXRIOfjfQxgTnXFgd7W/RBYZTm2orSVaSnWdzN+oqrvT0uVmi9ug9SSGy9L7FbomdXkP++8mfMYyJFDwQRMFtEIHFs3Bnz4kuCghLP3ezgEXjM2BuKse2DqxkbY6amCsgIyqm+uzWzPr8D3R4KCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tj5FE7CR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tj5FE7CR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U5OVqQ013527;
	Thu, 30 Jan 2025 11:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LgRBRv9OGmgvKS9eosjBo3FgoZ5t0S
	qyC0dUDXOFB00=; b=Tj5FE7CR/x6Af88ZUb6BQ2DeOtbwAvEViTw5HiofdbKWxF
	DEr7QQQ/BvPOgd5+p873LdkRr11tmpH9S6J8kYkq+dqf3CdSseVmw49FxF2/okKt
	qmp19+0g6O58tc7axFZ+pW8MxC8XRPclaJlHdx81ouKqby2A5vN9vKaS2sd3ehlU
	DVGVQJsTp0fPLhj2q2hH009+syPM7NE9kCAVENmxG04vJ5v0A3skVRo18ptjsxfC
	sFPiLM36+TGKJ+Yno7l7R/IZlrR8q/v778sQVAt4Mdp6RK1vCkGhxR5s3buMGwpR
	AHEVUHvI38i42CRLQGGSUAxshhofoSxQpmsCAfOw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44g3881kfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:37:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UAqjjM003908;
	Thu, 30 Jan 2025 11:37:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44da9sp2u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:37:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UBbFxX34537924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 11:37:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25A462006C;
	Thu, 30 Jan 2025 11:37:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5A9A2006A;
	Thu, 30 Jan 2025 11:37:14 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 11:37:14 +0000 (GMT)
Date: Thu, 30 Jan 2025 12:37:13 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
Message-ID: <Z5tkaaMNh83x2t/x@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
 <20250129213826.291cfe12.pasic@linux.ibm.com>
 <85863d7a-2d8b-4c1b-b76a-e2f40834a7a8@embeddedor.com>
 <20250130114615.6f591882.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130114615.6f591882.pasic@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zraq9mknQJljrj6qbBTeTo-uoj-UOkDp
X-Proofpoint-GUID: Zraq9mknQJljrj6qbBTeTo-uoj-UOkDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=271 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300089

On Thu, Jan 30, 2025 at 11:46:15AM +0100, Halil Pasic wrote:
> > > I'm not sure I understand the value of this. What we have here is not
> > > a flexible array but a one element array. Something that in the generic
> > > case could be many but particularly for vfio-ap is always one.  
> > 
> > You are correct. Only fake flexible arrays should be transformed into
> > C99 flex-array members [1].
> > 
> > Thanks
> > -Gustavo
> > 
> > [1] https://lwn.net/Articles/908817/
> > 
> 
> Thanks! Alex, what do we do with this then? I think you picked it up
> yesterday late. And I think, it might make sense to make this look
> less like a fake flex-array...

Dropped.
Thanks for looking into it!
