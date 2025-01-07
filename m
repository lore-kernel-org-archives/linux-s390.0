Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B033CA;
	Tue,  7 Jan 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239822; cv=none; b=ct99oEi7xnXomZ9RoRgZdOLPDuND0C+J9Ij5Ra4JlrsdxxiWcMcPyY+OfpuDqzFIuc8gavGLj5xaQb+l2PfrVZxRh67qCLdOTnBK2y1FZjpfxs4vLovkQa7dPXwZpQNi4T5JUzhDc9ijxu0wE6NK7AIFtb2bhkPoGdgLvYfIBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239822; c=relaxed/simple;
	bh=dPEBYYjGBQdVYXVs//TkEtyt4wWfqF15Mt2E+a2IcIo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gsSRWx8GhMDuxOI1lyTUP4raMRFPV8BkVIAyvMOH0mKWgn292df+nqFsWzENdJynFvfY3YccI6Du8ZcSdDDXBLUBJNpNyajcC3fNa4FI4ALnlOsE79NyccPXm9pkb6E5T21Oyx+Dpq9gUTvrf/2wNRa3QoP7nLfXd17c1ZVwiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NKteK+kT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NKteK+kT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506Nx5t2023884;
	Tue, 7 Jan 2025 08:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=i13OhI2I3cqU+X96/5pDJys5iCJku1SiUNUTdrHCVhI=; b=NKteK+kTDs0T
	5aWPHk/poa/7unlPT9p0cweUo0LlUijefm/27h8cqaZYqY+M54bVO5V5Tw212OJl
	hxhshfRzRIPtYkY0LMtX4DluwhG6ETM23UPL5YZP1TH1GkIWo+9IfNjiY9UFbBVf
	J2+dBXMVf6LULIJkvl6rxHvxWPwjGfYANnqL8Glt8COe9e1k6o7fyj2fDq818i7J
	e2GPBVb53dROZejn90XxupH1SmIhD6Bqdvv/b+z4aBSvAqCPc/DoIngS61wsdKhc
	jm2c73hGnuYXtuzz4kYQmVLCrg0vQDNqC9PHiAybjyDF8cMN2NalrpMRy8o7wvzn
	NSCDejJPEQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440sahhv06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 08:50:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5074cGF5013698;
	Tue, 7 Jan 2025 08:50:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygansmdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 08:50:16 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5078oF4J2490954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 08:50:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8CE358052;
	Tue,  7 Jan 2025 08:50:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 489815805D;
	Tue,  7 Jan 2025 08:50:15 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 08:50:15 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jan 2025 09:50:15 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fsch?=
 =?UTF-8?Q?uh?= <linux@weissschuh.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas
 Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] s390/pkey: Constify 'struct bin_attribute'
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <Z3fyc73WKFXOYFNi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-5-be01f66bfcf7@weissschuh.net>
 <2295c2a4-7d7f-4932-99df-fa9d4b6186ae@linux.ibm.com>
 <Z3fyc73WKFXOYFNi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Message-ID: <1753d01a50ad73867fb7829fbca6880e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vEK-IE62uPaGHwN_sGC6Lffbv0ovxpz-
X-Proofpoint-ORIG-GUID: vEK-IE62uPaGHwN_sGC6Lffbv0ovxpz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=477 impostorscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070070

On 2025-01-03 15:21, Alexander Gordeev wrote:
> On Thu, Dec 12, 2024 at 04:03:18PM +0100, Holger Dengler wrote:
>> On 11/12/2024 18:54, Thomas Weißschuh wrote:
>> > The sysfs core now allows instances of 'struct bin_attribute' to be
>> > moved into read-only memory. Make use of that to protect them against
>> > accidental or malicious modifications.
>> >
>> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> 
>> Thanks for your contribution.
>> 
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
> Hi Harald,
> 
> Would you like to pull this patch via the crypto or s390 tree?
> 
> Thanks!

Hi Alexander
If you don't mind then take it together with the other patches as part 
of the s390 tree.
