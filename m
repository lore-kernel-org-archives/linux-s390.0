Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162242BD033;
	Thu, 30 Apr 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563322; cv=none; b=Pou/uvG963TyiANm5XwsF/svxLsk94e174HGMy/QwF1SUHDlbyPwaWje1iaOFrPhkXC+hHj4BS72Hlt8nZ78UEYThpo2Sln3fs2YpbZflUtlL4z8BSN3de70V9YjfKFX8DcvAFpyh+WUnHmToP4A7SUVoP9fBovu52zLf5ljIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563322; c=relaxed/simple;
	bh=YFfoLAAZ7cD+uzYhyZIh7vMrdq9bmU482cl3/kh5TP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQmmVpUO9zDyNIN0iPo6no2rVY8iC4HyszzlvBeDceRPddCY1lHHIVD0lXieL4X6JyH6y6FUcyDoG+OASf7qAETdCg1XFYe6JbF/JlV0B0hrB3Djcij+vgkB7gn6J+Z6Juxts/4DnDK9iVxzD9R6856lPmAal4g/3FfY54sreK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j4Gqp8Ux; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j4Gqp8Ux"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UCxN2v3309760;
	Thu, 30 Apr 2026 15:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pQcjQi
	h1+r18BE13KO3XHzKuOHUMj1JshRvg+g3Tdu0=; b=j4Gqp8UxIKt2XDQDXPlWTh
	uDyZLBhnNr3lGOIxhxdAhblyAuOiNAWloLwBY3nV/641sIu8RRSbhh66h+iORgqL
	XFjsnuW/mde7dS1eC7eiMlAWOIQRlULOMRSs+IsG3K4GBdd/5GRnCOd2GMRnotoa
	9q4KJ/RIaafneDfzLwIEGpvBAd1euMONBKyuT8o/xVxvdp6xfOmW9pOPgkq6LSU5
	3zc6OaZCAsmDtgQzcqt0AP7GXsZ95wk6uJjjmfMQleIPmCBhiEH06OuXvtdoKjZX
	KKCEukOZRrsDIyNAC8yDAQCAcGdvOfEmShwtyQ2ZhM2RCy4lr6hDLCZs8rBMhtjQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jxyy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 15:35:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFNxR0030864;
	Thu, 30 Apr 2026 15:35:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw3phm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 15:35:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UFZCpl58393042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 15:35:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C7F920040;
	Thu, 30 Apr 2026 15:35:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A7A12004B;
	Thu, 30 Apr 2026 15:35:11 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.128.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 30 Apr 2026 15:35:10 +0000 (GMT)
Date: Thu, 30 Apr 2026 17:31:06 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] KVM: s390: Add map/unmap ioctl and clean
 mappings post-guest
Message-ID: <20260430173106.1da375d8@p-imbrenda>
In-Reply-To: <92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
References: <20260423235316.3665-1-freimuth@linux.ibm.com>
	<20260423235316.3665-2-freimuth@linux.ibm.com>
	<92f35384-7b03-4071-b7f9-32375b2badda@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE1OCBTYWx0ZWRfXyrLqkOgRzpqV
 /b+lW/rgGbEL0hno6KBJMn9m+juPP2zOapfY8GNZcFu4stuHE2qwF7lcChX3TUHVZ9luPAkVPtg
 PWbzHdkPJKE1//iIl/Kkz/YMXul1OvrebRfIneSBWC+pXzDWy32/aEJeERJQp6NjyVSCFezHtTT
 o2A840TR7ECSOu57WLz5ikHwlcgDiKzL5eo3JiEVigZkt8ae/2yZ82/AW7nj67BYkTXQEBVgo9X
 z+M7q5JNExAN+tgA1LFGGBxZlzVhRWACSdvaA8NKcVEPp7lE+MoqOvwdmBhCUHgTk/XaWaWxY8y
 OLKKaBFKOtEJFC+NyAH4Ol5nkHby4vvXWLWU/KUHd99rl8laZAQY17/ga8szSpoDDbyZv+sUU5x
 iacgFLwkd7kemkvCaAXAjrXnJOTKkuC2/wg0rj8/DIUwnOxRrY/B/VmfOmqLqnq8eaMvfklRtSW
 bWFJLTS7oY4IMDTA8qQ==
X-Proofpoint-GUID: vFcKKeeRYvb2yXUSs4bnD6dXywnThX8r
X-Proofpoint-ORIG-GUID: vFcKKeeRYvb2yXUSs4bnD6dXywnThX8r
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f376b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=PPAdYmjkh_biQPjiqjUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300158

On Wed, 29 Apr 2026 10:44:51 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

[...]

> 
> > +		if (locked)
> > +			mmap_read_unlock(mm);
> > +		mmput(mm);
> > +	}
> > +
> > +	return page;
> > +}
> > +
> > +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
> > +{
> > +	struct s390_io_adapter *adapter = get_io_adapter(kvm, id);
> > +	struct s390_map_info *map;
> > +	unsigned long flags;
> > +	__u64 host_addr;
> > +	int ret, idx;
> > +
> > +	if (!adapter || !addr)
> > +		return -EINVAL;
> > +
> > +	map = kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
> > +	if (!map)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&map->list);
> > +	idx = srcu_read_lock(&kvm->srcu);
> > +	host_addr = gpa_to_hva(kvm, addr);
> > +	if (kvm_is_error_hva(host_addr)) {
> > +		srcu_read_unlock(&kvm->srcu, idx);
> > +		kfree(map);  
> 
> Drop this kfree(), you already do this when you goto out

have you considered using __free(kvfree) and let the compiler free map
for you automatically? (or it doesn't work here?)

[...]
