Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483E37EFEE
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222956; cv=none; b=FMdS+I2CNvIjR4jC6jYJnVBqg7VQGVr1be2yfKsPPGvJQxnMSDs2OEZOFWjIZE6t4gSyFYgeDPbiPMRx3AFfXz1NnS654L1+JY9I48P6ELEa96KhJiZ3O1NuGMIBhYlCQ8TFc0EQxNipEEb8v7qFRhlK0maAhnRQUGy/Zr18Bmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222956; c=relaxed/simple;
	bh=jWRt3QoZdweK5gEHPVpOfS5OtHFgcJyb0dz6CRu+PV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKk8DksG02QX5csIJlKVSPXam7kSXQ+gTJINtrJ8CSfCjsJ2yG3KIn43vFwrHvtknYCY/RdcsmUaj/G0WdGtdoZyiJ5myi6+TvJNUQ62k7A1qk/yag/L/DWI+YXmWqMg3fvBgrhntlWDIAxunkV11NnvaYU7+l6wbMgzEYhTysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kXDq7qFF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kXDq7qFF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmvdJ1826997
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D9P7aW
	rO+RN+9TTLLrcNwcmqhHkCkZtqaE9v3S5+XUk=; b=kXDq7qFF7+Jrwgy4Lc8Kit
	sgkXBOFHAH8e5qvkEWXtAI7kScNGV8IhQ9KsPEDO7qETeSuyHqjTU/VJR449TWqk
	Xs96i/5BMBfcZzXSYPEtIknWskzj7v4CBkd2DHxrV8j4uG4DZix/4qjIQ1RWOVD/
	XbswzbCg4AFAPg40T3pzGgH8BbJCQ4lYdbA4+wPM8Ild8zjvAvggUJMkILx0RN9S
	kjD/NRtPpAd4+0Y3Le4+rbJclrSXM2lQ5EiZJx151uHPnW51aDW1WPNs4cgjQFgo
	j6zJI197Lx7v9wvyd3OJu+zE641LkUwCrKcQro/35dPhbOX065rOMNhQtQT9rWsg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgspq2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:55:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDnqN7015483
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:55:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3hxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:55:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NDtnGR43778476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:55:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B3672004D;
	Tue, 23 Jun 2026 13:55:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2E620040;
	Tue, 23 Jun 2026 13:55:49 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 13:55:49 +0000 (GMT)
Date: Tue, 23 Jun 2026 15:55:48 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] pkey: Fix for PKEY_VERIFYPROTK iotl
Message-ID: <87fd8266-cff0-4f67-a5c4-a18c507f0045-agordeev@linux.ibm.com>
References: <20260623102016.3930343-1-dengler@linux.ibm.com>
 <20260623102016.3930343-2-dengler@linux.ibm.com>
 <05c89f53-760a-4014-bdba-6aa58d86c7cf-agordeev@linux.ibm.com>
 <989332c2-721f-4e6a-b067-158b905163b6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <989332c2-721f-4e6a-b067-158b905163b6@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNCBTYWx0ZWRfXyhuuS/l6okN4
 g9bIKR6TvJEmx6NzVIKXKQtAd5N34MsYgv8FC7RG7kEA7OyBdVMhMJ6dhOLpjY2UFLCtc0Dfzjo
 XgNMNdNqIaI5TQE0K5O8sIgX9Gg2bfp18t8UtqzXWwPlDkI/0uYKl3RVjt8oWgLQOccK2AWGVND
 +V92bT4rP3DRQZdK8VmjV6KgerP1oqSGcc7JdQ0SSHTCRZlHIRCUNDUQ5BKwG3Dq8IGpwMes+N7
 /HlqGYAEy44+zadJtBeKNBiTb2zs7kE3Lm3T17fi9WQefpdc0D0HFnIHhH8TH4XqMB79XcpnQAV
 aMR78ksG71hYsKBpIh7FWXST/w/5GkiPPuXSvzNPOImgmBVe9zT1/GWKTg732mevh/fHO4+h7ww
 CxPgvZXvlMJ4IZpuJ7qRI6XNorIQ3iiR72TO4ZymB0jJEXeOmeWakXlDBHnX/jr3jOHJRlQm+ob
 V2t3pKRInp4tnX5a5dQ==
X-Proofpoint-GUID: sLWVdfY9Epm7p1nP8mcc9DCjZjBYpJ2X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNCBTYWx0ZWRfX+6DL1vKDplje
 R0t1xPH4Cf1+hyOPrRXmI59yl8NH83RqKp02IUoQKBKOYw0ANwqg3fHVPGuuFnnL++4xTH3dXoq
 IH63qPAevqkgadFbdPIqfZOGX1gCDj8=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a906a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=OtpZoFH1trkK_Ge0ZKIA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: sLWVdfY9Epm7p1nP8mcc9DCjZjBYpJ2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230114

On Tue, Jun 23, 2026 at 03:25:51PM +0200, Holger Dengler wrote:
> > The patch description is too indescriptive.
> > Could you please suggest a more specific one?
> 
> Sure. What about the following:
...

I rather meant the Subject Line description, but at least Ingo
likes the new commit message better :) Could you send v3, please?

Thanks!

> Mit freundlichen Grüßen / Kind regards
> Holger Dengler
