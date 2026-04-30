Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B4539E18E
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584645; cv=none; b=QovEltCb9ulJ5PZwhFIuBSB1VSu8euQLNZkOj5RoX/Lz+hIcqW4TW44RyxtWNi56Qlu1hRBIkK4A8Z1NGqbzikALR0GmyKFUhrIwcquZYrKeDf6VDxmGXI+harKbw+mfKDFG7JBlOF7/Ieprr80LDDQkD6PyVYBvduhHeuWyD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584645; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qGylEdWjGXvbaLZxU9J6VYSwiFQbIdnWKWwKWeZoDM/eapuZBEjSaDbreU6B6yALYytOX98Nm1JVUGh8+ijUu9Eghx60MrnviSjh/0Aea11UA4qTemYFRPNqmvngqsAPfXkfKbXk0VL/EvxXdOdYDZGhHGI0Y03daTyEKDd44/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ch7IlXPA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ch7IlXPA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UKIEFw1854175
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dve0g07m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so1448456eec.1
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2026 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584643; x=1778189443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=Ch7IlXPA+eZq6Eq5ZFF5Uqh/UdqLv6H5DjSMdVSvGFq++vxKpetP6SOsFHMLDIIi2V
         74rhPc4vWOlxDu8ouC8OObqJEwdq7+Lt9JFj+CqVhPmy0V+zOEn9H0A5Eh8FnyBzh2q7
         ff4zAtDm1dewZ1aCbamQdsr2f9euuoz1QsWDwKI0EIE90Na6+LIzlNC/agfKgGqTTbxj
         XhpFdawbdKgPMieewBkX1HuqCt2XNivTeoDW7Q/LwOljG+ixOnA3+ABmPeP0gesvopEM
         7/Ex5XoWAgMuqlJxvUv6zLQ5tvUCu2gO2sifYiohtok+ue80W+ecRRBGhkjXYGklHijD
         HQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584643; x=1778189443;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=W4Lls876nnCEFVpH1sP99f5zRhaqymdo5fmsxrSueSxn0n/39ZT/VaIyHVkEZfWsPU
         Wrm39m6FM7Rzgxzf0jHDv9/sxaow9OkHwyNxyKXA6GQ24JBaO56+sv9qYWy0/kgWSYd/
         o96sEbL0b903FKPSxAkBHc70znE2xi5MufL6JmU5goiuKlIi3TTXmXLB5WXOsKt+zb9h
         2y2MykfZ/4CCEZK7Y7jPFoN7mlsil/yg3TAtANjfTqhmLGuPDzQVawuFLP383ODUAwb2
         85t2s43wLCjDdrLAJFBe1bkFkLbJqmw+xKJQ/JUpDvebNv4qGtgiuIHFt2+ykBpwNk1C
         6X5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/LXOEx8g1xq6FGv+I/ogOeD0Qqbq2kcvSfnBe/BhSn7FjQUQTtUtTlAOl+x0eEizKNyZMIBrx97ArT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7mHDAuHnTEmFdHwyicx+Au3TyLqq9WLe/lFknPghCeR6DMSG
	cY5v/3xnQ6u6CXdk2DMySG0ebaeOHO9Iyp1nNbcjc1BgrhKGaprEaedWrwXW/WwLvBTEVlViXIu
	Q5UZnloTD+FqejPMp9EWoPvbEwvQy+vQCu7hsfaoqZkM9Db1kj/YuKFsynV6RLAfg
X-Gm-Gg: AeBDieumq1pgI76omTlbZNQX6eEzdIq12i6DpdpCOpK7HqGTWBTtTKsR4n3/PvAiMmk
	IeNmL9LyecVh5q3SPED+r82xu/gF+yedMc+VaFkgRiuCUKkTsdUkKWca2yix6FzHJIIuO25dStW
	D00bzyuxTeuBZjqjczIPhvZM8jghZ4xt7CXkoEHAK68FbcvVY1aDE3bLLcv/xtfMOBnfPi4pUn6
	6WSUQpf4xSxetQxCsOo9ZGw5fUnkULMIMD4SESS4eHjt3NHoG6k6eipn7HyTTFsojoBF5EQkeLH
	KCXF+zkL9/6Mt7eaEUcBE+qtRhbpZWW/Ujxss0oT5jGsGStuQu9khRHpLj9/2izWj17HOfc+IMs
	abzE+2jRbyexgdrFgVWjWL4mhPAqmBUqUoGr8oVZaNvd/JBUD3xOKHkaSBk4rQ5GHYvbXKzaz1U
	/soO2ed6nGg+U=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496789eec.8.1777584642724;
        Thu, 30 Apr 2026 14:30:42 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69f3ca03 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 4ubg-8qQHOIhGxgG7SjacS9Bf0XLmnEc
X-Proofpoint-ORIG-GUID: 4ubg-8qQHOIhGxgG7SjacS9Bf0XLmnEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMSBTYWx0ZWRfX6X3HDZRW9oTj
 LzpWvLAMI25xSPUUcVXNzcaTtQOEEY3TO65plZKBWXBtvPGlc/iCgFd2xuxG1z0l58+kxB3Pe7n
 dChP9GbQvO1Q83WzcH+PogsRSd6P6Z5kSvoK3shMJf2xi27mNADo76n0y36aDIVH0jA6cNcs2iW
 yvgn+YVDmkqNPGXEo+7r8vExmi6thRTTMirpKaHBaUtTEBwpSmr15twViTcvOZRK2jd+K2Cljha
 R8dZ2MstnqVWDNO/nSG9MIKE5/dfUGNqBs/pwWjtpLfbbjqFt/XeGAt1lpQfC9PkWTrFrlaP3EH
 v/Cbr0mdBKHPu8eM3FGppKteoeTB0YBGVwrR2OozuFx4vLL2+z+dhUpq8ZIxzdQyGrnbSLvjsmi
 3Mncg7RLuMlOdTLG1h6VGVH6gSp5i4/5ZEd7IEfKEhlB2O1+VnWowK+Exnr57h1a8ofKPth8man
 qua6wg6bTWP/d9yqS6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300221


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

