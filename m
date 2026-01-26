Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23413382E3;
	Mon, 26 Jan 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433109; cv=none; b=qizBK9RQ8ZEFHanq6OlnhAorkCRJ7AbO9rx4n1JY+KIIC58/oH7DvsqzpdYc4+mRUfaZjNcW3Mqju4j8ZENe74QEgSuX3gSN6Jbxim8jq/0EoLvITiqlp7PbcVuUKQ6azFGuSW6ik9LZfScv0BMhC83X3hr3ulnZiyLUkciXQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433109; c=relaxed/simple;
	bh=HzovIko6p1oZiDuHaWX+trvrpsQeRFadqkx3PZQ/G1o=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jOP7KMmQP9DnDd8Wk1HlPEqFwp0hR04pzpTj4x2N1FF5cm0Rakl4qXrG6sgEIHitFPFy1TWTB73Zu27txvrdRE2jJuFIwJxKYNWbKyp+KClbyUutkRWfhFqDMgyvPiwkctq2WlcNydf4XS9SpMx1P1+RpkSwwvxp6gwNtzXMeME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FxiDhn0M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FxiDhn0M"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60PJuLxo028552;
	Mon, 26 Jan 2026 13:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JI/+pT
	wyNrmLic2KBBIzLBvMgqE9z2pLpfVA1fdwKp4=; b=FxiDhn0MZIoEicZFvOjFST
	YkcnsDNSn04p7Re2TpRX25zALVcL6e6UTB95lm8lTtYYvWE7j2E/THmk2uA1a2W+
	8xHQ2/GXdtWBFuV0syyVTMCWIXtuY/OKo3/Hnr3df1+mp8QNP9/xYbx+5b9UC+i+
	8dDDKHVoUxfef+joBTOycc/0RFKB6dU98BQ12RNlBoLUKKzOzQ4spNTkj+5M6vFy
	w4pP7JaGQcvHb6ZKkL5wmBL1gM6wGWW3HJhIrNjjcSbiyfjsiFbFvoVS8P3oyOO/
	ekz7tWvdaEMexdlxDCmS2RgziU3zDHcE7x6j3aBrmsoBweT/c8455fQDPy6CK9xQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7g3ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 13:11:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QAqMVt006687;
	Mon, 26 Jan 2026 13:11:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy4rcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 13:11:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60QDBZmc51773810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:11:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C615920049;
	Mon, 26 Jan 2026 13:11:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 937AE20040;
	Mon, 26 Jan 2026 13:11:35 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Jan 2026 13:11:35 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 14:11:35 +0100
Message-Id: <DFYJOMBIETXN.2WABG9BS0HG2H@linux.ibm.com>
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Farhan Ali" <alifm@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc: <helgaas@kernel.org>, <lukas@wunner.de>, <alex@shazbot.org>,
        <clg@redhat.com>, <stable@vger.kernel.org>, <schnelle@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <julianr@linux.ibm.com>,
        "Benjamin Block"
 <bblock@linux.ibm.com>
Subject: Re: [PATCH v8 4/9] PCI: Add additional checks for flr reset
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122194437.1903-1-alifm@linux.ibm.com>
 <20260122194437.1903-5-alifm@linux.ibm.com>
In-Reply-To: <20260122194437.1903-5-alifm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rYiUiZEHKW-IeWPsppGRHuF7bxKDqW-s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwOSBTYWx0ZWRfX826iJkkZUHPr
 LXfOhiISsptOTfMl4roK0qYGEqUpLBzlHE8n0X831KQOX80BaEj/lJCOjqfFStMIjBzabevhoiM
 OT3R8QT/h9e9PQnPnplZg4doNxD7yTJLYHrsS5Xv1MhHi+4FwQSb1htdPw2LMs0JfbcWZuoju9R
 ZL9W5vOGQNVfRoGd8qoQTgmjz3+WTABnMFUHphKJrumJKkcq9oDcPBii08gL7IGIST8mMqxn6oN
 gJaeo9LKb1KNMIen0louu+NnyBtzTLuNTNsV3lytAdxqsSrnDK+EGZD/KYOKICtKzj8vRGBYV29
 /tMUPDfiH2JEBp2v4XPGAMRQFxbK/wCJuOlz1kyNhje+2/bMFDDGzCe6Sjrstxb5xjM3BOwRv2J
 YYfNBp1faoqJRbEY+AcEqqQwO43gPbFvrt/bnV/QyzAeYxPBEVuXVjD37+jRBeDhsJA9XCSpWyd
 4lzCEOu0RLZS2Mmrk3w==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6977680d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=23YMnp3XVaxGsJNIDs4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rYiUiZEHKW-IeWPsppGRHuF7bxKDqW-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260109

On Thu Jan 22, 2026 at 8:44 PM CET, Farhan Ali wrote:
> If a device is in an error state, then any reads of device registers can
> return error value. Add addtional checks to validate if a device is in an

typo: additional

> error state before doing an flr reset.
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7beaf1f65a7..2d0a4c7714af 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4358,12 +4358,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>   */
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
> +	u32 reg;
> +
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
> =20
>  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
> =20
> +	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
> +		pci_warn(dev, "Device unable to do an FLR\n");
> +		return -ENOTTY;
> +	}
> +
>  	if (probe)
>  		return 0;
> =20

