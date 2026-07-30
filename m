Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3003B4E9B;
	Thu, 30 Jul 2026 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397402; cv=none; b=T71orEGa5OmwTSO5LlQBnxsSOwyIU6efDmLL6mqFTYjg93SwPy23QQWUKGqmVQ1n2qgVCoy8qpc2M6Wz8U+KzxObKVBanzmOPBFX1dqNeRezf8/+LLz11iiHtWFVvNhkdI1tKW9PHe3hrtB2/4EnWaeDzs/6kMpq88/RhLUOnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397402; c=relaxed/simple;
	bh=xUpoCJh1D3SIcVEJsFPbv5pi6TS1juVZBIJ8JRC/2bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWGut6mjsOxEnqh4P2jMvwSKLQjaZP9QDW/FXR53p4JTNv9EEStoTY7ih/GwN98gqv50m2WLzfNcvLIdg2alkOi4XAyOmdnBHq7C12/ywqdx6ABArXzqjFlWCl62LYh3Jyq0CuX8P+3cPOQ/AQ2ejRJ+ARJcavnA8F6eah6aoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ANH1OA2y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ANH1OA2y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6m7mj2197716;
	Thu, 30 Jul 2026 07:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CoDQpB
	pPUL1W0uYTeMlEHsMSPTcbNkA4JxYJq7rqwT8=; b=ANH1OA2ygDZm7Kl5PFm60X
	tEvqn4Ea3p2YqkHp8M1I7oQI7Tfx+fDo4NDZZaGushBQeRd0zBU1TErOdEEx8JxV
	nWCZxNQMl0JmLKoW7EsU2HYolsPGWdQIraU8UNwRcAvS0sIcUTCqfyQjyyWRT9yJ
	acIl3PwXWSfQW7+4WkVxT+bPIJ0b8L1lzRU7qGBX2PIuK+9ZkidmkADObUYGN4W4
	WSbntRZ2HBdW1UPpj7vxtxcG9rvFhgTgBTOY+r0o5bznf9gyt6wYGrjMb4P/PDnx
	hILkNtCpRee29UXtnHUFNszcrrs7aSkvl1HuF2rulnEXVrG5DQ1Svfb4o+gNzpnw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nwreq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 07:43:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U7fGXu012875;
	Thu, 30 Jul 2026 07:43:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgj5h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 07:43:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U7hDsd25952596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 07:43:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C2CC20043;
	Thu, 30 Jul 2026 07:43:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE4420040;
	Thu, 30 Jul 2026 07:43:13 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 07:43:13 +0000 (GMT)
Message-ID: <c9272bf5-1328-4f58-8128-0d3e7d6c58cf@linux.ibm.com>
Date: Thu, 30 Jul 2026 09:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update s390 specific vfio sections
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
References: <20260730053437.3288650-1-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260730053437.3288650-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1MCBTYWx0ZWRfX+w45tcRkH9U2
 VUzP6NCIirLO8OLct1N9Hr+H7wptxPE9+O0kdYLBULnwQvUBilLFthwUcjXKz6wJW1dO5dwFrzd
 huF7blFpQm5YQnLmVUn/ErdvHu6VNmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1MCBTYWx0ZWRfX7GuVTQZ27tc/
 3DZAYf5XO7h1NUp0W6TEa/29z2WXMlXK06PBNijflvkYE3JEI5rRtiie7RDgMFng9wDPwFD53LO
 P4R74YYyit9p9rqMsA45x6z/5SJJJdPAF9egmKe+7g7M+BUiu6/6z31BzB7Hw3LjwQjgxMFvYIY
 jTRPRb5sCKjfNDVzd5eohnXdhvm4fVeVvwAU/OjiOlLGjFA91+UGqKdz1XfDQ2GFZSClxrbmalP
 /3P1RNE4syB7Tt9UcMHLD50DjWcDgGxkRpWTxXdwKqKg1ExuUWenwtCGEJGHI6Oz3/78lfhM9c2
 SLPRjD/XnD8qAupt4t3bBvCofmf5rkmqVrTv3M71uaDP+Hy6G1pLhx5Rfcj5t9BDTWm4N4Sy8OZ
 qd0QmsSC1sJIs3iK4C7UGQX68ThAeV3Pp0VL0SdOZoEXLMwyzT9Y6qXyZk964RV6pJhTmTb166/
 e8lOWWSaowVtSAjmmnw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b0096 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=SRijaa11Sq0dWenywQMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Zq1VmqXzU2ZgpolZatHdc2TkArrToYE1
X-Proofpoint-ORIG-GUID: Zq1VmqXzU2ZgpolZatHdc2TkArrToYE1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300050



Am 30.07.26 um 07:34 schrieb Heiko Carstens:
> Update all three s390 vfio sections to clarify that s390 specific
> vfio code normally will go upstream via the kvms390 git tree.
> Add a corresponding T entry to reflect that.
> 
> For consistency with the other s390 specfic vfio sections rename
> "VFIO AP" to "VFIO-AP" and add an L entry for the kvm mailing list.
> 
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Acked-by: Eric Farman <farman@linux.ibm.com>
> Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

FYI, Paolo, Alex. We had some forth and back (e.g. going via s390 tree)
but in the end the kvms390 seems to be the tree where most
interdependencies happen. So we will carry things from here.
common vfio code changes continue to be carried via Alex tree.


Unless you complain, I will apply that for kvms390/next.



> ---
>   MAINTAINERS | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 716acfc3d7c1..b95bebe8a78a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23890,12 +23890,14 @@ S:	Supported
>   F:	drivers/s390/block/scm*
>   F:	drivers/s390/cio/scm.c
>   
> -S390 VFIO AP DRIVER
> +S390 VFIO-AP DRIVER
>   M:	Tony Krowiak <akrowiak@linux.ibm.com>
>   M:	Halil Pasic <pasic@linux.ibm.com>
>   M:	Jason Herne <jjherne@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
> +L:	kvm@vger.kernel.org
>   S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>   F:	Documentation/arch/s390/vfio-ap*
>   F:	drivers/s390/crypto/vfio_ap*
>   
> @@ -23906,6 +23908,7 @@ R:	Halil Pasic <pasic@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
>   L:	kvm@vger.kernel.org
>   S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>   F:	Documentation/arch/s390/vfio-ccw.rst
>   F:	drivers/s390/cio/vfio_ccw*
>   F:	include/uapi/linux/vfio_ccw.h
> @@ -23917,6 +23920,7 @@ R:	Eric Farman <farman@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
>   L:	kvm@vger.kernel.org
>   S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
>   F:	arch/s390/kvm/pci*
>   F:	drivers/vfio/pci/vfio_pci_zdev.c
>   F:	include/uapi/linux/vfio_zdev.h

