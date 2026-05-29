Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04F351C0D
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050236; cv=none; b=azt+hUmBdLgdOr2AEyhKUFOWZFtnSZFE03NuPoUVqgXQ3DKrCiU5B0LEcnnveHKEg3m/zrb/k82FvKkR3EmVc3J3QIEA5GKZs0W9T1EVMmTZ0ZqDOxWLV7fCZsEruv2BE4znl5BRtx7Vu1zUi0XZsJtEJc5XtI1UuefE9BWSWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050236; c=relaxed/simple;
	bh=kbaEGlJF5sfTdWwBXuL5m/iGY6a5ZRG8FPYiHBpBIrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwVVwudfXOuRoJBCNhIMWkN/PO5N8l+ksCnZdPSHPPJ2HmvM4dHH0RD6ZfX7c2uztYTvMf8nyGluWJz9d+RPT32dx3GmT7YRwCxgg3JzTSzH9sI/SMX37UNAXGcdvS6+osPdm1N658eYCh+/KhMmMC38eVfqjBhOB9dWi059vNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QK1VGSRG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QK1VGSRG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLmhis3218468;
	Fri, 29 May 2026 10:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=n5+1B20rrUVJEUpCaDLEg1uyNHf9SP
	QcZyCTHLnqbbk=; b=QK1VGSRG5QuLnhHe/+TrfYmBKgkOawX33SSDF94A9fP7Ax
	1oqU8giGbDwarQl3whbbwSDxMIGTdu/rCwkm0JGnStSHB45HGGu3ZtqQDYlT04xs
	PdT2lRjQM8gx+AOt9nEZ4WirZW5PoKk+a4d0ah2XNciDxNZq0NfaMpWMLATwc9F/
	gzBIf4BGsPzK7j7BWxGNg/tRNh+/tN/pT/0fToMiO6ZJMOI9cJAvx4FsNqA98fzB
	M439JVPD+f1zwlvijObwDl2+AFJMRLD0GVv6V3ILtROzT96K8SzfKV4ulQGtZn5s
	cQINBje8w/lopKfNi4jados+0tsfmpoVHU6njftA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bfqk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:23:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TA9O42022777;
	Fri, 29 May 2026 10:23:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc532q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:23:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TANlIh53608922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:23:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 667A82004D;
	Fri, 29 May 2026 10:23:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDED520043;
	Fri, 29 May 2026 10:23:46 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 10:23:46 +0000 (GMT)
Date: Fri, 29 May 2026 12:23:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/6] s390/qeth: replace get_zeroed_page() with kzalloc()
Message-ID: <20260529102345.26496C83-hca@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-4-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX1dhMZuW+3Kji
 D7HQTpctdRCjCGZMCCZ96a1gQwiYXm97ks3A5OtZg2ofO7fcWVnBDlFIKQqlUOGEiaz4QbzPohK
 P2ZO2Z3POV6VOW0IAlY13McPmucYmGK4prQEApfNgaH2mX3awICgi1ucWu85kNByrsemfO+RxSE
 myeoEjVLw2vkmvbmDMtVJ4Dx+FlfwyC/vCZC9UBd3gv7ojrA++GZp+FipMIlv2BtwtdBpvx/xar
 PqolOmQOkLXfMd8ZWDN1YbWmw8DH9mQBstj2b63t3tx4q5ERsWrsvQsth+hj6KNeQ7sqGvXb4CX
 31g2mH3MfrTIIar8deyOy4zwpHlReoDdZJtJk4DCa7gYaf9bg3+heRQpysfdpGaqNFhPmPqXyuW
 UccX+GeqxcSBImGD2yB8hZ0QS6JRCsbBImNePbPLdvVf/iBr37O47Xdm7r4V3gC1ZnXd0/dSbW0
 WN9ufZiD9M9VsjbwfzQ==
X-Proofpoint-ORIG-GUID: 2oyUuyD03O_cBJvoV2qHUSwhURFGctvO
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a196938 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=5SmsgU5nlSgK4sXYBFIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 2oyUuyD03O_cBJvoV2qHUSwhURFGctvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290100

On Thu, May 28, 2026 at 10:09:52AM +0300, Mike Rapoport (Microsoft) wrote:
> qeth_get_trap_id() allocates a temporary buffer for STSI system
> information queries used to build trap identification strings.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/net/qeth_core_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index cf5f760d0e02..9274087557ec 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -3362,7 +3362,7 @@ static int qeth_query_setdiagass(struct qeth_card *card)
>  
>  static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
>  {
> -	unsigned long info = get_zeroed_page(GFP_KERNEL);
> +	unsigned long info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
>  	struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
>  	struct sysinfo_3_2_2 *info322 = (struct sysinfo_3_2_2 *)info;
>  	struct ccw_dev_id ccwid;
> @@ -3381,7 +3381,7 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
>  		EBCASC(info322->vm[0].name, sizeof(info322->vm[0].name));
>  		memcpy(tid->vmname, info322->vm[0].name, sizeof(tid->vmname));
>  	}
> -	free_page(info);
> +	kfree((void *)info);

Speaking of ugly casts, which seems to be one of the main motivations
of this approach: the above adds casts instead of removing them :)

So I guess the below should be merged into your patch to get some
improvement:

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9274087557ec..20fb0d2e02a9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3362,9 +3362,9 @@ static int qeth_query_setdiagass(struct qeth_card *card)
 
 static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
 {
-	unsigned long info = (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
-	struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
-	struct sysinfo_3_2_2 *info322 = (struct sysinfo_3_2_2 *)info;
+	void *info = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	struct sysinfo_2_2_2 *info222 = info;
+	struct sysinfo_3_2_2 *info322 = info;
 	struct ccw_dev_id ccwid;
 	int level;
 
@@ -3381,7 +3381,7 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
 		EBCASC(info322->vm[0].name, sizeof(info322->vm[0].name));
 		memcpy(tid->vmname, info322->vm[0].name, sizeof(tid->vmname));
 	}
-	kfree((void *)info);
+	kfree(info);
 }
 
 static int qeth_hw_trap_cb(struct qeth_card *card,
