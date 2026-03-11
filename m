Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEA3DEAEB;
	Wed, 11 Mar 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242661; cv=none; b=j5jQ7VS77B8qIIVtZiNxhxhoDZzElJAXfFWoOBc/j9+/CwGc83klp2nIe0oh40gV0hgY36zxOfmCJtDlGBrjS+WlrJF1zprJ5+8gMsHYo9S8Ko+aaATp9rLjJMv7JmLggcFfj16BvQASC60n2eg41JnYGFRxrQWJZsvTwYx3PFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242661; c=relaxed/simple;
	bh=FPmTLEHSg6HFm+CSBC1lB0B6KYvFAqiaJB1bE8pLaeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOCDVFYF+iavdXrH0VKJ9YazWOHOr7yq60rIJiwmgUdPEW4t2/7yxyJFSSMO2Ud9517RtbO+aW/hah7nOYe+7Yud9XHe7TsG4R+CBjUHbV3UliiT5Ul7/Uo67FxiBemadIyeiiPAsyjmIHiQ1kGzqlb+b1SfxL9vyJuRu4Y8djI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XPIsE5Vv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XPIsE5Vv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BFC3fp1709369;
	Wed, 11 Mar 2026 15:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=j2udp80ekD+T28tQFM8ggP76OclqH4SbsPiT4+9AnGU=; b=XPIsE5VvrGNP
	pQQebnP73Hls/kif79mxTu/KQgJRfvJNJ1SliMQh1sHtdCZ7EqDT2oEDbl5P9L8R
	WLgmcvGKG+tz/qh/nU0n5H6oZR01vT4cCmFwEKGKx6wH01iVvy3VFNPFVBcRrqAl
	fxOVGVKfj7sr5/TvG40n3wLbaOLAIPtFNe6QPtF5L4ME0HaX/7Dvqjn0DWIJulWX
	IHdtlhCzbtSkOFoxaA1rwJ6V4a4Snq6psSPjuyZlL2x04bBBQDizJD43pQVgPO1V
	iru4tQiWVw24DgpZKX6axMDxSHns+3HC+bJ2yIRzADQ055zr/W7sgA2FIeeAyeck
	KyZUdX/jPQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mr0rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 15:24:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BDLqer015750;
	Wed, 11 Mar 2026 15:24:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1225qqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 15:24:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BFO8iK43057470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 15:24:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33A8D20043;
	Wed, 11 Mar 2026 15:24:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21BCE20040;
	Wed, 11 Mar 2026 15:24:08 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 15:24:08 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w0LPr-00000009dbV-3cFl;
	Wed, 11 Mar 2026 16:24:07 +0100
Date: Wed, 11 Mar 2026 16:24:07 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
        kbusch@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v10 4/9] PCI: Add additional checks for flr reset
Message-ID: <20260311152407.GB2161595@p1gen4-pw042f0m>
References: <20260302203325.3826-1-alifm@linux.ibm.com>
 <20260302203325.3826-5-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302203325.3826-5-alifm@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b1891c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=zd3bCVhvPp9dttV5fycA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyNyBTYWx0ZWRfX831PlmGPv7RK
 oxHpe0raDfNJBbwTGgkDdNpFYl8FqfA1j3II+7ulvDnD4fv4bOmYEQJKCOdT/2H9YfAJqypFwPM
 C5Usg2kxnwwF3nJLKz6XxUmtZXTfDvy4rK9qlf0UFn0Ei38bR4+3JoToXNX8NYWrBcz+KSGxxjZ
 7th/Eu6rtKULJPHCDDBRGtjfvZIkamVsU1qddNoKaqIMaA5CFHeBKI72h8VIMXH6ZKr4WyygAm1
 f7Rc3OMFpcxpUUuMCNT2LxDDlB420jdcrUMg8sRk9dojA+ZKQoovLRsDHevLIucV1U648bqV+Zt
 m/lkIzjNFD/7Rjr7crvgZz1D9faIwR7d9zLJqzaSUbUuRav+aYcoiFWAGdMJVMIdxcbM2LrE5AS
 sOF3Q7Ou0tmMNOEs3197+WwhmfDv5cTHNtXOqQqA/FDfD62H8aCgmqFbVPDhZvCuMWDTX0CB8fO
 nL91/HEHFRQxb40ezbg==
X-Proofpoint-GUID: moVAB9ob6kDdxoQL9HIlX4h3l2pjkTym
X-Proofpoint-ORIG-GUID: moVAB9ob6kDdxoQL9HIlX4h3l2pjkTym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110127

Hey Farhan,

just noticed a small nitpick:

On Mon, Mar 02, 2026 at 12:33:19PM -0800, Farhan Ali wrote:
> If a device is in an error state, then any reads of device registers can
> return error value. Add addtional checks to validate if a device is in an
                          ^^^^^^^^^
                          additional?

In case you do an other version roll.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
