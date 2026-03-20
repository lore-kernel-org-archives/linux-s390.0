Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D023EAB3;
	Fri, 20 Mar 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976906; cv=none; b=inG8fnQ3xVHKEgIWyhH8VP1sdivMZf6KolillqDcAxudNYcxY2u8SZAEh3Ea/7dje4Vegv1O0Acp6iH//h4XjI8uaUi/8geBc49iZq4hxPv7E5H/z7XCdJEnwFd3s/wDAtf+Cq3DZWu+MeFmZIRIIreCTU8MiiD4Fux/DPb7u3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976906; c=relaxed/simple;
	bh=gGbK1hlJNkFH+m2wLyf1yKsOfsiUVTktl0gahGS/72s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4S6VyPj0JSDtX/fqYeacahgNwAAD0N8uR9YJshoK1XbGW/PgKPD1V6hf/t+D5IwR2zTMpGtizwLrqnNhNRa6j+u7I1XLDzOvkDtDWtaExRPC+xorI/3X4YflC19L7ANIvKkW1cbeuFnGCZph4LxMzkMypuYv0PKU5FiFdZe8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WNeekJYP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WNeekJYP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773976900; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=euot9GX9Psoi1WN6TxY1zgk1VpiBJA8QKwf2sKbBPeo=;
	b=WNeekJYPe0LKc7+v9ue9xJzoy/1iNkg2xnRG8rycFRmOAcDCvEQsAQ0CQzS/6+oaUiTxpExgwKSfnvwdGZZ7Zujav7KNpIgreUqDVFsK83f+cN6ibGRGv0kroILGiMJ3Rlf+IWeJEPdTXoW5vdep2pM2PeNuTGNN2LbbZGrkbxs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.K7P-S_1773976899;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.K7P-S_1773976899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:21:40 +0800
Message-ID: <ab7ea070-47c8-447a-8e9e-ac471063cf8d@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:21:39 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] change young flag check functions to return bool
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <20260319201839.2dfa704041b8f13d8dbbfd3b@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260319201839.2dfa704041b8f13d8dbbfd3b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/26 11:18 AM, Andrew Morton wrote:
> On Thu, 19 Mar 2026 11:23:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> This is a cleanup patchset to change all young flag check functions to
>> return bool, as discussed with David in the previous thread[1]. Since
>> callers only care about whether the young flag was set, returning bool
>> makes the intention clearer. No functional changes intended.
> 
> One observation from Sashiko.  Minorish, worth addressing:
> 	https://sashiko.dev/#/patchset/cover.1773890510.git.baolin.wang%40linux.alibaba.com

Yes, good catch. Will fix in next version. Thanks.
