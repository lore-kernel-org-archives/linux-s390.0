Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B071288CA6;
	Fri, 12 Sep 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670992; cv=none; b=ZbvuuGOcmv3xF0RvR3dr2fguZEPD3zr9iwcHKbqNU/K5s8k5gUSvLUt6y6wyrNlrB4SnvOY2e/1u7bi7r05rIbhRJXBu6VDEfVsvIcQIrP9SG+ge3V018Q2Smt+zjvD8pMqaPmch4NEDd4cQUT8g7E2KJsHUAuQe4p/TFJ6JBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670992; c=relaxed/simple;
	bh=OrYwcxq9JwKgyAIknPY/bkf7jivwjuknfJ3ivnJpUxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6Bp0So2noLVrC3tAqQKDoaWWZrcVbEOHOT//dZn1JwJacgx9NwCoSV3KL9WbWYUNG336O1Ya4XaLJMUZrcnyiMmvdDD5P7N6QLXqGFmhEVYXVtPl2BF/ZQMHoUoo5PGuIdQVofj1smssDZl5SZHdLWjq/1mw31/Mty0t7Fp49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oi/l30a6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oi/l30a6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C6gQkO012151;
	Fri, 12 Sep 2025 09:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nsOR35F/dhR/hvHjJEeIbBnt+K0GAt
	bpzcjpD5pn6cU=; b=Oi/l30a6RK61LJXuAIxx9WH4KK7cOWdM/q/TYdGrFIK7oL
	uwVW4rYAgGqNcfEw9lUDhuj7u2twG+oMTXXqUvHeBpHDA+s1+hnrKKu6P+GcJBl7
	TsLQWR9EVudgDC3vgV8txWPObytZdN0yO8OBgITeVvbDkhPVxoa0En1Kt0ECkGn1
	hEknwaCtL01f9KExHToIRXBhP0Pe04pI3TF5gN+Egu61QIyOXxkPF4Dbg31fnWUl
	1nPkWgEk/aOMkvYZgzsESV3xelftn0l3oTrFSeKcu0eyxOJ/h5USjw+PeDyAiQET
	J+pkzrUxl3DnYmdRs7gM/umKckpELJixiFW3KuFg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydfh29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 09:56:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7DdjP017163;
	Fri, 12 Sep 2025 09:56:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmt4ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 09:56:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C9uM8f34406672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:56:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFDAF2004D;
	Fri, 12 Sep 2025 09:56:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5230C20040;
	Fri, 12 Sep 2025 09:56:22 +0000 (GMT)
Received: from osiris (unknown [9.111.34.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 09:56:22 +0000 (GMT)
Date: Fri, 12 Sep 2025 11:56:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/hypfs_sprp: Replace kzalloc() + copy_from_user()
 with memdup_user()
Message-ID: <20250912095620.10147A01-hca@linux.ibm.com>
References: <20250911214539.1483234-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911214539.1483234-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QDMmIkRIwvAalAgv7o5FG_OXx888oGZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfXwczV/wDCeKOE
 9JgtG9TJkZap/9lK7e6mi2gL6wCKmXJu3m2EL7ZGGUJcV/KozgPZJHQQ+h4d2Dehb0mb/s0Erie
 SYYn5Zg2PHPWaHRy67nG2b2kSXmnoTk+2RPUxz6HRreouRnOtURrn2oQgJ65iorjTbQg9M1aMj3
 xfcajPxVXx51XKTIr5XgrMhTp20njD+847nDwj7fJNgIFXwyViNcTZKoWwHNsGsQLfGy/MNf8lz
 4oI/NCvZkNla8Tb3GWx4jx/yZqWVYMGiDQqkov2cO8yY0g5NDxFg9p5Qle8eUfg19/4s6shrPvS
 RoLbc+jsXjXVQO81GAMv/3QE4PEkdGVCRghV7irG1VeJxmMLJYyps1MeeVbOC2El53/mg2sOwXp
 ssWrvJTl
X-Proofpoint-GUID: QDMmIkRIwvAalAgv7o5FG_OXx888oGZB
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c3ee4b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-POyQxMZsFGaTXn31B0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Thu, Sep 11, 2025 at 11:45:38PM +0200, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify __hypfs_sprp_ioctl().
> 
> Return early if an error occurs instead of trying to allocate memory for
> 'diag304' when memory allocation for 'data' already failed.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/s390/hypfs/hypfs_sprp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/hypfs/hypfs_sprp.c b/arch/s390/hypfs/hypfs_sprp.c
> index 9fc3f0dae8f0..be11634bc7db 100644
> --- a/arch/s390/hypfs/hypfs_sprp.c
> +++ b/arch/s390/hypfs/hypfs_sprp.c
> @@ -73,15 +73,16 @@ static int __hypfs_sprp_ioctl(void __user *user_area)
>  	void *data;
>  	int rc;
>  
> -	rc = -ENOMEM;
>  	data = (void *)get_zeroed_page(GFP_KERNEL);
> -	diag304 = kzalloc(sizeof(*diag304), GFP_KERNEL);
> -	if (!data || !diag304)
> -		goto out;
> +	if (!data)
> +		return -ENOMEM;
>  
> -	rc = -EFAULT;
> -	if (copy_from_user(diag304, user_area, sizeof(*diag304)))
> +	diag304 = memdup_user(user_area, sizeof(*diag304));
> +	if (IS_ERR(diag304)) {
> +		rc = PTR_ERR(diag304);
>  		goto out;
> +	}

This is not an improvement and also incorrect, since kfree() may now
be called with an error pointer. Please don't send patches like this
which aren't a real improvement. This is just pointless code churn,
and a waste of time.
