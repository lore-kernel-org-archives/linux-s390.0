Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5382F42
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617784; cv=none; b=FihBoXJ3RQfBvK4rvqwkN3CQ0DBjF73hJiddF2RrSkGMs3F25bkiPpfQx8t3UAm6j2dsn3TQLvrmjkact7Hs/puPt2E2+if7gpKtCXbN3Dh+g8kCSzsdKrHsXcKRghD+18Aq6pgmE8e7JXJxlfO7rUNn49SapcwO9AOaFG9/CI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617784; c=relaxed/simple;
	bh=2YzUw4ibXl3KI3L7uUEmZk5hJUEa6Zl/OEKfNaHtAAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN71ljwd39+H1ShvAIGXYIvJ71317H5shftGkdJ9L1RIUpLY3iSjOIgXDvHouggvWBhbIoT0DNj864X9/V8ER46U8iFqOvqMbcvA8QhNDdyJoy1VC3a5dM82N+Qv2JGyXJAs8TNlJeLKQiCArH8Rh0OOgycFUsQ0CQN/SC1xYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bAtTfHR+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bAtTfHR+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DM9XUZ028794;
	Mon, 14 Apr 2025 08:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Hmzt7AVfHp44Xm6OXAaq2RN45yyM14
	davcsNigKDXfI=; b=bAtTfHR+dAQVAIMor9ZIxP19DjGNphCpl0D25I+ppLS0Ie
	JSuRQgzrOt4ZXnoOWyPv4nOUadPN7Uy3zWCaPiJachSeRK84yTchDi3yTsc7mUFo
	w6epliAbY3armxAUbmrFdCv+sGsj64VjIbuM5LcdqWVuMpxd0uW9bgu92hxCybaJ
	L5j1CSHKx66Bllbi0XQQ5ptAPQdRyHpelFpx6To71/kIFaBk2xLnQCNdpaBpzt3o
	Dh0+R+WptuLYSEr9CGMOA4iyfc1AVOSlSlHTqie4wBYt9T29BaKyTAINAaJ3U+9t
	fn1LF4bfWUeHNRKncCa0ia3XiIrUM5kZnZwbpTVg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460bqpbeu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:02:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53E57E9M016689;
	Mon, 14 Apr 2025 08:02:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460571vxgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:02:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53E82tgJ56230182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 08:02:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 001432004B;
	Mon, 14 Apr 2025 08:02:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C0320040;
	Mon, 14 Apr 2025 08:02:54 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Apr 2025 08:02:54 +0000 (GMT)
Date: Mon, 14 Apr 2025 10:02:53 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 22/24] s390/pkey: Use preallocated memory for retrieve
 of UV secret metadata
Message-ID: <20250414080253.19379-A-seiden@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-23-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409140305.58900-23-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9x64_totKnQiq1Ffn5Q9CDg58vdA2RAE
X-Proofpoint-GUID: 9x64_totKnQiq1Ffn5Q9CDg58vdA2RAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=470 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140057

On Wed, Apr 09, 2025 at 04:03:03PM +0200, Harald Freudenberger wrote:
> The pkey uv functions may be called in a situation where memory
> allocations which trigger IO operations are not allowed. An example:
> decryption of the swap partition with protected key (PAES).
> 
> The pkey uv code takes care of this by holding one preallocated
> struct uv_secret_list to be used with the new UV function
> uv_find_secret(). The older function uv_get_secret_metadata()
> used before always allocates/frees an ephemeral memory buffer.
> The preallocated struct is concurrency protected by a mutex.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

One suggestion:

With this patch `uv_get_secret_metadata` is no longer used by any code.
I built this API specific for pkey so I think you should remove that export
and the function from the codebase to reduce dead code.

Steffen

