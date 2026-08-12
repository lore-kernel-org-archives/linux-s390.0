Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B5319617;
	Wed, 12 Aug 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534666; cv=none; b=UWROrGOUJoFVJkst/Qmb7eGXwV/oWqUFREy+OgFgq8eCZt7jv/s51BpsK/YyQ5J8mdmwHrs1hahgmvLSptTiVmlXwxiYWaty6MbOKt3oz+y5v+2KSIyx2EYGUJLI/VgzMfJtB30pSjGYZwxMN7KsmxtIiLt4rOIWtDtsasAetVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534666; c=relaxed/simple;
	bh=c6wlnLWZv13m+udzGPcvnpzIovyfKjAjQUO5YLB2Esw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQQPpS6D/S30VfGPBCtOgetquWRBIV+TWxlYAQDvJjbqmZ47iaQZelZbLzlxObVORfCU7cZaPgh9pWsS3xErpj0XZfh3fZSsO75rX07zwsf2MfoUjtZPV3kbI0xEj11AOjCAixIl2GA2eK4PKoRl/ZLWIu6VGhYpMMFMV5bJbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mZ25xPXw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mZ25xPXw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3pMk3258666;
	Wed, 12 Aug 2026 11:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ovBFeG
	9uINPKboqxT3bQJW0AjfdKleXkQ3vZ0kImWgY=; b=mZ25xPXwmiHWWzwKDkz5Kf
	sjfe6OKGPKBzzdxdzDy24i3fUMpbL8i552hJieHePV2PNxDawyeEtojDtYgJtySc
	gLuzE8NjcyBItf2QKjpHTnN4V3LxfH3Xfh5xWITqD/PnxwFmD8TqW79g9+KM/xZC
	cnT49O3s/2RRRjAgfui9iWdIXcjXouWHDKSheMJjOVaEDvdki/eV1taZplolBrZO
	7DHVuq2pgMzkBcpEtufunLFUPLKRq+2MIVb6lUzmX9c2cN4HDPUtcC6dxXosPl23
	4Gd03B25C9mtqsczZaenHcpgPbvpxpwDbzakvgGO7dE2GvYX+o3i9oeBQRnlAyew
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9j4pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:37:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBQIA6009003;
	Wed, 12 Aug 2026 11:37:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq5xp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:37:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBbbeS42139914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:37:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FBB720043;
	Wed, 12 Aug 2026 11:37:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27AED20040;
	Wed, 12 Aug 2026 11:37:37 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2026 11:37:37 +0000 (GMT)
Date: Wed, 12 Aug 2026 13:37:34 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v2 4/9] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
Message-ID: <20260812133734.02967d81@p-imbrenda>
In-Reply-To: <48891afe-3d25-4a11-912c-4c2f7c86b0a2@de.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
	<20260812104436.109741-5-imbrenda@linux.ibm.com>
	<48891afe-3d25-4a11-912c-4c2f7c86b0a2@de.ibm.com>
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
X-Proofpoint-GUID: rd3lz_-vmGBVXMps5_lsPFpdCViTErxK
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c5b07 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=HnjIGms7Bc_f-azJU0IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfXx0GGoK+GXFUU
 j4SUuHHHkO2gvbgE11CxtcUI4BcXaF6+5tkS+BNCbRVhld12Hpwjg1Uf5FtWzkSZ50C9+prGpSs
 QbsuFpOjZl+kteA7Ua7dl2WW1WkgzGVjL/G4yHlVtn5kiSOniJxLJ2gy2pohi8mG8Ltr2NTbBG2
 K8TUq3alzwCkDWDUX3JX6lzf/JengStJD/S5yg3O1+Pb7nTpabqM/EU+cWL1ScKJAn+xFWvS6zK
 OWVhOklKMOLtpJIpRyO77nR6winYUgnMVY1hnwelhFjATGRl4n+WFEkKpFjpPkO/vYkzyO3lzId
 S5kuPuAyMBD16Zka7xd2n0Ua4/yPf2X4YgHdjpw+R8PlXe2I3WPqtTxePHcjUPE2EPRtSzxUn+e
 PsbkCRTx80ABLuSISkrKrOYXlnmPFIsQuRk4L3B53fXQKSlMSJ9z9+GjX+/vMtqsltVj6WEXvUC
 CA39pSR6Dss9cDqI51g==
X-Proofpoint-ORIG-GUID: rd3lz_-vmGBVXMps5_lsPFpdCViTErxK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX/DBlWs+xqXRx
 6bxBGPN8Rb6bMaSQY7E8n/wwrz2hxOdk+HsrtviYuoDaWzdjX5A4GPm01bnitpkRmVi1ciX64q7
 yaB/IL6f/Ze0LCRRngT8ltkc8BouEGY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120093

On Wed, 12 Aug 2026 13:03:39 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 12.08.26 um 12:44 schrieb Claudio Imbrenda:
> 
> > @@ -3017,26 +3017,30 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
> >   				       struct kvm_s390_adapter_int *adapter_int,
> >   				       int setbit)
> >   {
> > +	struct s390_map_info *ind_info, *summary_info;
> >   	unsigned long bit;
> >   	int summary_set;
> > -	struct s390_map_info *ind_info, *summary_info;
> >   	void *map;
> >   
> > -	spin_lock(&adapter->maps_lock);
> > +	guard(srcu)(&kvm->srcu);
> > +	guard(spinlock)(&adapter->maps_lock);
> > +
> >   	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> > -	if (!ind_info) {
> > -		spin_unlock(&adapter->maps_lock);
> > +	if (!ind_info)
> >   		return -EWOULDBLOCK;
> > -	}
> > +
> >   	map = page_address(ind_info->page);
> >   	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> > -	if (setbit)
> > +	if (setbit) {
> > +		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
> > +		set_page_dirty(ind_info->page);
> >   		set_bit(bit, map);
> > +	}  
> 
> This marks the indicator page dirty before writing it.
> The summary twenty lines below does it the other way round and so do both
> slow-path branches.
> The order matters because kvm_get_dirty_log_protect() harvests destructively.

yes, that was a typo, but the patch also has other issues, so I'm
dropping it for now.
