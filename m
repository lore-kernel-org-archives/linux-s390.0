Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714C23315B
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793948; cv=none; b=ZlLb83bSpgvHKaCuMetin8QTFb2gkbJccdUZyeUOnfySpWqHgdfgwY04wP2bQ5pmMKrkoeJPQfMbW/AOrzMAXcO9CYEUWPDTzJKb5FCt69q95ItBTDALHjAGZWC5pS4aPDfzLVdRe/Z67vXjUE1tddq2qj3WryPD88e/g3wtAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793948; c=relaxed/simple;
	bh=daO8Z1+7Mqg0utm4R0Jjq2/5V13neDikskQPvvrPKVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvPoz7HM+mRqM9oIYmgimcQSX7k//kEYbw9i405G8aRTKHgmzQHyUsc7NgdpgCX2c2LJOiTKQI+Vl4oEOUqJKcwKUPPT6/Mbsy3PE9WI1JFncNoHc1gv98qCws3nMfKc6eqY2eHldrO3w3Lyt8VnceAcumnqo+ZLB90kT6GE/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZ9PWyau; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZ9PWyau"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8sNMC028143;
	Wed, 16 Apr 2025 08:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KAuMNpxKGmcYf20dqGmTao2Zf6zZRI
	3SevW8++OsbEw=; b=PZ9PWyauUfbGGEYElGBmEtf9fflxQD3tavQqD8YldpQdyq
	Zbbqkba2GwMrw92Vw8hBp0RT1EBP38y5MTEMjWZadrcJQS84LiLoF/3z6kVDoMPw
	HI6E7FMY0D4IiAfobPfBW4VBhZW/BVICwl7/kaflqWnyjnpkQshmW8UGSGBXu1b1
	tjZ6TXBvua5tI6mrX4iNdZQvc4p8QhHdEGg+ShBqmuw4KSwE3fhhIcmMeU3RhKf5
	0RrWMVMXedHjO+4KNCNbRoB7MjEyVMzB3AcI7+u/odQ4RXoU4xCkiLImUJc2DLs3
	8L/BUOmQP0YQD8zh2c4FUse0oYyqndoBlFROH/DQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ykt2ats-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 08:59:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G6OV4d031061;
	Wed, 16 Apr 2025 08:59:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnqg7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 08:59:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G8wxTY56295870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 08:58:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 454A220049;
	Wed, 16 Apr 2025 08:58:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1353220040;
	Wed, 16 Apr 2025 08:58:59 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Apr 2025 08:58:59 +0000 (GMT)
Date: Wed, 16 Apr 2025 10:58:57 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v5 22/25] s390/pkey: Use preallocated memory for retrieve
 of UV secret metadata
Message-ID: <20250416085857.150408-A-seiden@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-23-freude@linux.ibm.com>
 <20250415145257.12735Eca-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415145257.12735Eca-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -c8wS9_5XlR-0lI8KvaE_U0QoDxI87IB
X-Proofpoint-ORIG-GUID: -c8wS9_5XlR-0lI8KvaE_U0QoDxI87IB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 impostorscore=0
 mlxscore=100 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=100
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=-999
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160069

On Tue, Apr 15, 2025 at 04:52:57PM +0200, Heiko Carstens wrote:
> On Tue, Apr 15, 2025 at 04:24:35PM +0200, Harald Freudenberger wrote:
> > The pkey uv functions may be called in a situation where memory
> > allocations which trigger IO operations are not allowed. An example:
> > decryption of the swap partition with protected key (PAES).
> > 
> > The pkey uv code takes care of this by holding one preallocated
> > struct uv_secret_list to be used with the new UV function
> > uv_find_secret(). The older function uv_get_secret_metadata()
> > used before always allocates/frees an ephemeral memory buffer.
> > The preallocated struct is concurrency protected by a mutex.
> > 
> > Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> > Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> > Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  drivers/s390/crypto/pkey_uv.c | 37 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> ...
> 
> > +static int get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
> > +			       struct uv_secret_list_item_hdr *secret)
> > +{
> > +	int rc;
> > +
> > +	mutex_lock(&uv_list_mutex);
> > +	rc = uv_find_secret(secret_id, uv_list, secret);
> > +	mutex_unlock(&uv_list_mutex);
> > +
> > +	return rc;
> > +}
> 
> This is a change to the previous code, and potentially is also a problem:
> uvlist is not set to zero before it is used (unlike before). The condition
> code of the uvc is partially ignored, and instead the return code of the
> response is taken into account to tell if the uvc succeeded. This works since
> memory was initialized, but now the contents of the previous invocation may be
> used to tell if the uvc succeeded.
> 
> Or in other words: I think you need to add a memset() call to uv_find_secret()
> before uv_list is used for the uvc.

Yes you do. 

Thanks Heiko!
