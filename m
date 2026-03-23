Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF92332906;
	Mon, 23 Mar 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265282; cv=none; b=RoXI17EvGSh5hs1n/tuKdQwqlGtOPGjG8sShRzpeTuEgMgWCT09qeRenJD7DjEroq2t87Qc8FC4zHaAYqm1Ay8uV3yktnAOqzFYmeiadCxxA/9eN9aVDfsAlGXMR0Ql7r5/m8p+W4ce++wzdREFeFo4oYxVpXORTprNuNZYOTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265282; c=relaxed/simple;
	bh=fzJTfCgF8PdnwX293mnKEBTddh+OdF8GU5lHnawXgHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0NQUvWb971ZNQ3+oqvI9u/eBX8h8dxxajP2Dp4lQQ5JFf63/6qENF4epBIx/2qPtV6Fjs0v2vEPYQ/7fF184iXj6dCakF3pBejBrgu1f6Y9GUWRP/ShMXBzNJn7K09MPr3r+JXDrVJx0qIfQTHQxwgBLf1nv268qTigSF6iuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nN1LpKjE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nN1LpKjE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNTrRd669847;
	Mon, 23 Mar 2026 11:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3aDI2G
	gKtND2lp0FpXXHse1kbd6u6CuOOlRldCieva4=; b=nN1LpKjE5mGuXJh767cK72
	0Zg9za5l4d1MGk6Huylry8aQv8d9e7iKpzwgvx/6gwjF72w0dyVqJviQFqlFsIwb
	0e5xAg+RraMYI7Mm8FdLTFc/3/dhAarjrZFDfhFlx9ri1j1rPhRePNAihMOm1slD
	uxCluOEOGDxTWkBt+IZF4XzU5YTsl4XzlbopT/ua7iMSlh4feLGRmvz190nqPrQD
	mZDW4dX+0+pOtnCSmpORHZHhV7IEugtED8a/aNTv9WcUeArOLCmtQvZzLiNJGh9B
	YXiUh8bNng3MqtRmaVbJPgs7PVrbanu4TgbyKGs7bQXeB/k517yIwjD2JfxP7l4A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktup9rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 11:27:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N8LK44011788;
	Mon, 23 Mar 2026 11:27:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjvxbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 11:27:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NBRr2K55116036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 11:27:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0902004E;
	Mon, 23 Mar 2026 11:27:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51BF120043;
	Mon, 23 Mar 2026 11:27:53 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 11:27:53 +0000 (GMT)
Message-ID: <f10356ad-2f47-4d8a-afdb-064174d7c113@de.ibm.com>
Date: Mon, 23 Mar 2026 12:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        gra@linux.ibm.com, schlameuss@linux.ibm.com, hca@linux.ibm.com,
        david@kernel.org
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-9-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260320161542.202913-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k56Ccnz9q8m5AFSIPXfPjSFLjg883RIW
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c123be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=q7j_574gMM1SWfO4ZYMA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4NyBTYWx0ZWRfX+2pXtYegyUVv
 vjAEJ67i7jnnojvczBAlYaiv9Oi8EhtjRa1sMasjo4nWpiUpRljKD+z2SNANHjlROMvj+j2zX5t
 5p/N1MUFtKxiNtlnBIeHFbkPuqR+WNEZLpUe/ddtm/l3hyPqEG+16HCnaLhsYxnjrdIv3NoHE7z
 g4IYDpcpAiljYGc/nE+aU1U/wT5Xt8BI+2sNIEgBcPkr5iLxR4C25L8/CJNYFOFcGPFvncmEaDU
 QhxXFd04nfewZp9ntbvHRFqPNleXFSkLiGzuHweQzsT3Bpm1FKlJRqyMLuDqKbmjNDdO/yozL5n
 5LfSvYzCfBzA9/bHNx9Kj8xY5PApkBeLBR21H5EXdEOdPJtFQoKdAWfC2F82uejmv4giQSTOVpm
 F5t6+Z2/519bFsBiMIiqE0CGbNrSnT8YlD+0RPrvOQKiULCfuGe7wJu5CyIxHkxXS0fGkhXUgxW
 /P1P572J39ke8Vj33rw==
X-Proofpoint-GUID: k56Ccnz9q8m5AFSIPXfPjSFLjg883RIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230087

Am 20.03.26 um 17:15 schrieb Claudio Imbrenda:
> A previous commit changed the behaviour of the KVM_S390_VCPU_FAULT
> ioctl. The current (wrong) implementation will trigger a guest
> addressing exception if the requested address lies outside of a
> memslot, unless the VM is UCONTROL.
> 
> Restore the previous behaviour by open coding the fault-in logic.
> 
> Fixes: 3762e905ec2e ("KVM: s390: use __kvm_faultin_pfn()")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Is this something that we could improve in the
tools/testing/selftests/kvm/s390/ucontrol_test.c
testcase? We do test KVM_S390_VCPU_FAULT in there.

Apart from that

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
