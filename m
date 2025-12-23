Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BD58287E;
	Tue, 23 Dec 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468978; cv=none; b=ZhEHaZJCrcuPirqFS6m8ctGPT7n4vvGEd8snadV8I1H9B3pA83CbrQO0Qw3YJXs/rTd75MfghHXGdLvrQLk3ktu/rHSb6tdrWAjhOm06VKUQTt5q0y+Te1zRKS+CjsbfJYwOSZDtNTiVcaZE/9Do47ORCB2XZ+S/J8gVJ5YMNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468978; c=relaxed/simple;
	bh=C7G8Tb8ubAqP8NF7lFxYChVIDlXIjpTGXaA8Bveb8dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wx15sskPNfRkYJhm5ua3sw3B5BaZ3ZnqSa1UgwG+YTxuG+iLp5klXNHNS2fQ8bcmcyI8RboOwFfv5Pr0OXjkZLA+RZCFmVi7fMcVt+b5jezymXOh1A7kn6NfAyyv7j5vVwSTiTEWb+q6UCEA2eDWMYgH6q4lOxNX5mVpng/X0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h43t/huX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h43t/huX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMFeGuI007059;
	Tue, 23 Dec 2025 05:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hUQC9Q
	qHxVAbj0doEs4oapZTuSJT6eFBkNbzGOXoVrU=; b=h43t/huXajZ4jf9NCBRDYj
	p/cMXkPwMgHWgoOQMd26dLhNQ1IGee5Dd3QhTmgWA8J+vLWQtACnQVdnamFyd5Tf
	20RbyP0raQj7+vJyr1P8ps2CFD17F53bJ8wVsDI0Ih+ZowRpKQ0GGXCU0/Oea1i4
	h7tUcozKcT2NUjAtm/XypP2NljapCSP2UGGBnsWjE3CJR1KxVFC0+2hOV4NFYITP
	DLA7zsZBpEHXS0ozKqfB8QRly6E/IKZl8k74FuNIXeWXT9DACVWgItuPnwJ8/Kv0
	OITX6IFwluivKVwChOlFQvnepItmlIG1p3MY2dVG36PZz3fO/fBRCuWS7GB1Z2IQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh4bbtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 05:48:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BN5m4Ie004968;
	Tue, 23 Dec 2025 05:48:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh4bbt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 05:48:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BN25mbv032310;
	Tue, 23 Dec 2025 05:48:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b68u11ff9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 05:48:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BN5mKch52429126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 05:48:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD0D920043;
	Tue, 23 Dec 2025 05:48:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD18A20040;
	Tue, 23 Dec 2025 05:48:16 +0000 (GMT)
Received: from [9.124.209.226] (unknown [9.124.209.226])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Dec 2025 05:48:16 +0000 (GMT)
Message-ID: <972f7168-6dba-4a29-83e6-91f31355b90e@linux.ibm.com>
Date: Tue, 23 Dec 2025 11:18:01 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages
 are unsupported
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "David Hildenbrand (Red Hat)" <david@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251221053611.441251-1-sourabhjain@linux.ibm.com>
 <87a4zcml36.ritesh.list@gmail.com>
 <655cc605-2ce1-4ccb-8cc0-a0a31a9c89fd@kernel.org>
 <87fr93ky5i.ritesh.list@gmail.com>
 <16fef7a5-6853-4a6f-8d27-e005fa351eb7@linux.ibm.com>
 <051628be-ed70-4a56-8704-f2b8cdea1984@kernel.org>
 <e97c41cd-44f7-4560-bc75-79283a438e91@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <e97c41cd-44f7-4560-bc75-79283a438e91@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=694a2d2a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=hSkVLCK3AAAA:8 a=i0EeH86SAAAA:8 a=jlNTI0j22tuo82LuuOcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: 5InZCgUrAuKcmji2nC7kndDcD9vdRhpP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA0NyBTYWx0ZWRfXy0fLUe1vayjV
 kV+7Uk/SF/f0PKKexUvcaZ+ZEKNF6UIiBmjoLyXWPR9CPX7OJeudE8DetFJb6fwYDpIHvep8BML
 FvmWzBGQo8kgJKZiMJ1goMztGjyCYMZRHijrZsriMy/dr4Yhei2IZ+3W2+kURjc0WNI5Hr0gOHJ
 HDOW+Xfd+ipapPm7xNHTA2xVswX8HPNajZYpu0m7Xd4DQQ97bXZDT+ZC8PQ4wEKEfEcNuYDrJei
 5+F3Yi0n/djy9LSjhBeJxkiUNHOFmuRJfeqi973qFJfNZK14MtYHkE7yxEzMWZmdrQzPm8kMLrr
 n97CVaqERBSYhA+nrI9rryOSP25AhPnRAKbeSbE/3SmAVPksqu/G6XtJUzF8AkxROuCIKD0qROM
 cY3YqTSPUOG4WHomj6F3yd6uvx7RMZ9A698qFoAXMvWSlukgtNXICO5MhRb66fqFR2783Qi6SI3
 LBSkZYWPauWZOAfXeVA==
X-Proofpoint-GUID: Euac01tVCVlxww6eiT2IVB5NPNIOAUsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512230047



On 22/12/25 16:24, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 22/12/2025 à 11:28, David Hildenbrand (Red Hat) a écrit :
>> On 12/22/25 06:57, Sourabh Jain wrote:
>>>
>>>
>>> On 22/12/25 08:42, Ritesh Harjani (IBM) wrote:
>>>> "David Hildenbrand (Red Hat)" <david@kernel.org> writes:
>>>>
>>>>>> Coming back to the fixes tag. I did mention a bit of a history 
>>>>>> [2] of
>>>>>> whatever I could find while reviewing this patch. I am not sure 
>>>>>> whether
>>>>>> you have looked into the links shared in that email or not. Here 
>>>>>> [2]:
>>>>>>
>>>>>> [2]: https://eur01.safelinks.protection.outlook.com/? 
>>>>>> url=https%3A%2F%2Flore.kernel.org%2Flinuxppc- 
>>>>>> dev%2F875xa3ksz9.ritesh.list%40gmail.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cfe40f4881e8441ab3ebf08de4144e747%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639019961377096292%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Dnvzy5kJ%2ByF9GJjIw%2B12FTjaVgeAM2gA9g7hsYl7Qok%3D&reserved=0
>>>>>>
>>>>>> Where I am coming from is.. The current patch is acutally a partial
>>>>>> revert of the patch mentioned in the fixes tag. That means if 
>>>>>> this patch
>>>>>> gets applied to the older stable kernels, it would end up 
>>>>>> bringing the
>>>>>> same problem back, which the "Fixes" tagged patch is fixing in 
>>>>>> the 1st
>>>>>> place, isnt' it? See this discussion [3]...
>>>>>>
>>>>>> [3]: https://eur01.safelinks.protection.outlook.com/? 
>>>>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2Fb1f04f9f-fa46- 
>>>>>> c2a0-7693-4a0679d2a1ee%40oracle.com%2FT%2F%23m0eee87b458d93559426b8b0e78dc6ebcd26ad3ae&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cfe40f4881e8441ab3ebf08de4144e747%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639019961377117150%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=bOO7FGN4jAtX3jjBnJVpSurmM9rGmz8vIs1iGtbm1gU%3D&reserved=0 
>>>>>>
>>>>>>
>>>>>> ... So, IMO - the right fixes tag, if we have to add, it should 
>>>>>> be the
>>>>>> patch which moved the hpage_shift initialization to happen early 
>>>>>> i.e. in
>>>>>> mmu_early_init_devtree. That would be this patch [4]:
>>>>>>
>>>>>> [4]: https://eur01.safelinks.protection.outlook.com/? 
>>>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D2354ad252b66695be02f4acd18e37bf6264f0464&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cfe40f4881e8441ab3ebf08de4144e747%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639019961377133860%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=0yTuECy%2BBGDLiSNYuqYH9xGBOSxiRLxAtW%2FWTQU%2FB%2BA%3D&reserved=0
>>>>>>
>>>>>> Now, it's not really that the patch [4] had any issue as such. 
>>>>>> But it
>>>>>> seems like, that the current fix can only be applied after patch 
>>>>>> [4] is
>>>>>> taken.
>>>>>>
>>>>>> Do we agree?
>>>>> I think we should document all that in the cover letter, an describe
>>>>> that this partial revert is only possible after [4],
>>>> Yes, I agree. Let's add the above details in the commit msg.
>>>>
>>>>> and that that must
>>>>> be considered when attempting any kind of stable backports.
>>>> Sure. I would prefer if we change the Fixes tag to the one which I
>>>> pointed in above [4] (with explaination in the commit msg). However 
>>>> I am
>>>> still ok if we would like to retain the existing fixes tag and show 
>>>> [4]
>>>> as a dependency.
>>>
>>> I think we should keep the current Fixes tag with an explanation for
>>> dependency
>>> on [1] in the commit message.
>>>
>>> Would anyone have a different view?
>>
>> Whatever introduced the issue should be called out in the Fixes tag; 
>> if there are dependencies for the fix through other patches that were 
>> already merged, that can be documented in the patch description 
>> (relevant for stable or distro backports only).
>>
>
> We can also use the Depends-on: tag, see for exemple commit 
> 9517b82d8d42 ("nbd: defer config put in recv_work"):
>
>     Reported-by: syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com
>     Closes: 
> https://lore.kernel.org/all/6907edce.a70a0220.37351b.0014.GAE@google.com/T/
>     Fixes: 87aac3a80af5 ("nbd: make the config put is called before 
> the notifying the waiter")
>     Depends-on: e2daec488c57 ("nbd: Fix hungtask when nbd_config_put")
>     Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Thanks for the suggestion Christophe. I will use Depends-on tag.

- Sourabh Jain

