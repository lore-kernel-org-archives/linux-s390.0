Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F79423149;
	Tue, 28 Apr 2026 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384586; cv=none; b=JESEbwwtp77NBLR0wz0xOTF1lLrJ8fuJMPYGGvE5THKr8FOPzv6Q8OrAGcqNqPNhLgZ3imVP5mDCEj5OwoCUbejmn61vX+SQnMPz85uCNDecL3DZltqYBkeVAkKMbpZBtnkxy5P3wcBloWGh/H25wYyVq9qotEvxH3LthO0UZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384586; c=relaxed/simple;
	bh=ttWv3Nosg1Y5O6//uFv9Zz+EtU+AynnvMau+dz1ZL94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4Hbxk+f1Ji8VFNqSl9j4IvP3xL2WvnctTmZs4iI3pvS5EAtgjE2kqKrytAhiykNilEirJVEhM9yUxiD24eTdmK9g0RSUvGZrUaXTlLfZXp2NKj2n2QOiDffPeg1DNaBiaASGLdHxF6OPSawET8VoCqsScZa3mLv6I2yk/dAkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AeBoTi2B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AeBoTi2B"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S2pR5u1904926;
	Tue, 28 Apr 2026 13:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eEk1t+
	14LEJrCCS13u1Y1sG1C5bathi3cWaESTHuNH4=; b=AeBoTi2BV8c3m/QpKW4itf
	hiLhbtFgKt5hEe04sKm3qtQZa4m8jttbFePBKlQicHutlY4POiJGcPG3hJ/RHdvK
	Fu+0EcQCWLXiu4zTSRYn79XcQvFehNZUz8HECsqf4mGDaF6rMWbUUAOwZP1E+qGX
	a7bWcyHSgNBR0ik2hDvfZQ+4ew6VLJjINmHc8LJOY0tZSEPzcKrRAeQCqTb96IXD
	DkhAV/gg0B6bCp4k/hU6MIIL/lOYtYsEjWNXiq3b7Ack7f9i5VH2DiPX9wAO8Kmp
	SzWrhxv9gMXLgbkNWPtOIPB3x8xR9ZJOUKiZj+DfMc0ri0vvtIXy3AmpjUx8TX8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r5sus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:56:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SDrmKL002551;
	Tue, 28 Apr 2026 13:56:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g9tba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:56:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SDuEIi32899398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 13:56:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A8220043;
	Tue, 28 Apr 2026 13:56:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C35B20040;
	Tue, 28 Apr 2026 13:56:14 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 13:56:14 +0000 (GMT)
Message-ID: <861c2116-7d3c-4f5e-ad83-0ca314cc6e48@de.ibm.com>
Date: Tue, 28 Apr 2026 15:56:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] s390/vfio-ap: Add live guest migration support
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
 <e8e07556-4618-4203-aaf7-e2e95c6fea71@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <e8e07556-4618-4203-aaf7-e2e95c6fea71@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oU0n5Qv2WnIIWa-v68qHwDQb-Cf-SW-G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzMCBTYWx0ZWRfX2klz7tM+RPKm
 uvZLDF1z+r3STMwys+O0ukUNj9Sg4sg6Eq8ANbJet6Tb/fouGfEJ3wZ7q7P+VGRvwkqw8ZBAiOl
 FdFczu6yVNqtvyHXjZSkzLUENAcfJ7kyTry479Q2QBw4riq0zizkPWhYCUhD3Mkz60pkDXJTp+Y
 9xdzK/Oo7EK6ON4/0WV0PVfZD7gi5mzLMShO1eoFqpbDG/9NOCodAblZQWlnm1dqHx/5lWNrMnt
 np/uLZU+jcKxKZJV/4UTztqmx3V61I78xOQ7JJQ5lEaxDI5Y+wJJzWjsf3+bVjETow4TPg13Xma
 GTG7vRTSXHz8ItRWnPEUhoWpnUtxsAE92ARIuDm8AXL+zK1Se8cSE88e+Qd+03f7RgZZ8nfM7oe
 8G6w/7V+Yd3MMoz8A41CNzkN3+YGN42AdzyHOiYh4ZM0euIoSGTc8SxjArsOuMEhUEpJnHfRCRi
 R+H8Fu1ZiWe8ALaoR5w==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0bc83 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=9fbRV5f1h4sZfp77Y00A:9 a=QEXdDO2ut3YA:10 a=VxAk22fqlfwA:10
 a=QYH75iMubAgA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: oU0n5Qv2WnIIWa-v68qHwDQb-Cf-SW-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280130

Am 28.04.26 um 15:10 schrieb Anthony Krowiak:
> 
> 
> On 4/7/26 4:50 PM, Anthony Krowiak wrote:
> 
> A patch review would be greatly appreciated.

Sorry, everybody seems busy. Can you maybe start with having a look at sashiko

https://sashiko.dev/#/patchset/20260407205100.331150-1-akrowiak%40linux.ibm.com

if any of the review findings are correct?
