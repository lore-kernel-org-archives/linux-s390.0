Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28AD44E673;
	Thu,  6 Aug 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026495; cv=none; b=WhKoa++9NvYA7Sb3admgZKB01syKT560Ex4rwPsLG7SqNoSWJNEz5FqUhO5OZwx80YLZoMlKfuiQ7lCLz7omKTmouG93lwwZ7NQe2zhl1u8S24cLsBkx4gyDcQGzkKIqZNQGfziK8YsOzq0HABsw+9MBJ5ckyMrLnUyxnwHEJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026495; c=relaxed/simple;
	bh=xT+5TYkiAumq+s0rgR2EHzJ++Fp87+V/F5njyp43bD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpED1X0FmF6FAzjulTrpYbuw879Nk4VkUqmUDs8rcW8Fsscq3vV47R78KXcj6vvGtXgb7WOR9472G+5zulOURo/slyLpA8SDpPA3bOAhLWjmiAwmkpyDZ/Kj5mKnVtQx8wzghF45xeAZpvJM9fdUHsarRXFHTJO9MeL1XdYVTkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PiDE6Gc2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PiDE6Gc2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676DGNdI1071337;
	Thu, 6 Aug 2026 14:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XYD9OR
	lJcfIhmnnxbWJKu03KGdjyvPU0kIn3Hu/iQIA=; b=PiDE6Gc2uAjio5ckJ/XZGI
	hJK2RZfOn0iblKbpPBdQKpwSSk+OyfXmBrRhNxc4iMBKjVM8T3NFtzxKU7xDSX2U
	V1HdoMwqp6kMnrhi1xigAn7+/bzCx9hGfjgNNz0lutgMB+zVj55t7t8glzc62jTq
	htRsMgxixcKhwEzDU2YHO7wbKeckn2Om0tI7Ly5kvklbW0Xeew5GITFqouA+MR52
	G/ewo5XPQmSnswj3YHbfmM+/lSomdq4DrUxmHenVXnxgmGT7PeGjy0gpjrmYq25z
	v9eIce6i+k6CubZtJ9J0R8xcUbJf14zzOuicDgghkAxBzCb2aCkf+X8xePMzSZpw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a48pv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:28:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676EQXdb010955;
	Thu, 6 Aug 2026 14:28:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qunqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:28:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676ERRIH59310574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:27:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 556755805D;
	Thu,  6 Aug 2026 14:28:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 734B258057;
	Thu,  6 Aug 2026 14:28:04 +0000 (GMT)
Received: from [9.61.23.247] (unknown [9.61.23.247])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 14:28:04 +0000 (GMT)
Message-ID: <2926f8e5-9762-4197-bb67-1ab214d4864b@linux.ibm.com>
Date: Thu, 6 Aug 2026 10:28:04 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, stable@vger.kernel.org
References: <20260806140342.611294-1-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260806140342.611294-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7499f8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rFaDrkc5NCzgIuy8vgoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AlRSAbgekApLo-oYt3WPMRYAMW8xzShw
X-Proofpoint-GUID: AlRSAbgekApLo-oYt3WPMRYAMW8xzShw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX0kws0p4QlvCo
 VCib0d5RjBRRqoix7U4150t1ptt2pHM33Sqy/lW5qB/nu+VoqcuZqzVsMrxnHK3B1GYpIOLPVRk
 6+n+8e7yBmD50ymJjfN8ZtxZpT5Ogqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX87Mj5jrCClAO
 8A3LRtdnKMyGZZomRtttXRiuE3DeShshgQg1SInv4byyYaEXWFIApwPqUxeSr8AykEHLRIoVw6D
 66R0P4+1P9TcWz2DVQHf6+9GmxHTGByaJ4mJ2WoxNFVDzxeS3Nfzb6MUQp0Bb3fdT2lb/H9KsjR
 ji+TpLNzrv4jlEUZEL6GT71oyxjWNd4483LKHCrYalnmweWxhJs2kykjdTeq6fcjX5HEsA4rYRh
 Z91aUBscPr0sKWOyv56EWJZpSeIi6B1RBhq+NX6cdjv0em4KKFmRMtPLHReJN4Of8rQd7fOh60F
 OFsgJEXKGY9WuiTjTTElrr1f59fhDNcKQS/7DqXy6yj+so8g+MkhufT232IY8JRvL6PGmQiF7T+
 kOraay31UOUk3dTtADIuykqKlhDJ2yctla0D3QJNAqku1YNrhVaER4p5+egKj845N0iQSm9o1Na
 Uo1pHmrLZcomrJoe/2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060112


> 
> Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

I think you need to re-arrange the SoB tags based on :

https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Co-developed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

