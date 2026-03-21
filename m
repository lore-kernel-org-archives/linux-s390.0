Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302E2848BA;
	Sat, 21 Mar 2026 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774070586; cv=none; b=q2qBSLXJ5Y0BmcNJ1ye1XUdcAru3YWAF+nkoEUIuxuzCJg8Mh0Vno5IxYIgTSbvqc/7QDlAwnTioIQhFpQ8AMwmOmGRcRBXiBt/AWcNmff8dgn4Lf3zjmo7fq6A9P/gT/rbUBbTArt+PYuHQtsKwDALFCZ2RMxpFy+vn2NM+LMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774070586; c=relaxed/simple;
	bh=472mm4QQfaWJbuZHFqphCfZBxDAqe1OQbdC/+Hz9edk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6+WIGXALDaQ+LDw7m+fYAMyjMVlYnMxqOqyT7l4ARi7EJ3OwnPGHJoFEOKmGEr3YbzjA4JIY8kxFNHZZ3hGcvV0jF8YiWZZAEJrCFgls09L6f/PRKXLPUE5BijoO4Ml6M9R/xLE2LACgEnoSA3torAamUXKnNJUSzXxN4yAFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QB2NpBLo; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QB2NpBLo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774070575; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PcTvfZxxxHTOO8PPQsyM51dY96hQcI/WjTannbuBJtg=;
	b=QB2NpBLoqG5Crb3aZk79xMM4k0qroaojnJ192NzCjvMrCkbuAFUKExQ6o0R9Qjtt+r2tx0Y1YAwQm2cqaq6xgvHVTS/DzmsBtPLMfFOBGWVnTYfM5cPFA+ZyX2G/g+w2yJ6aVcb3/5lH3xt3rWJr5LaGUVNJ54D+usGTPzJF25s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.O-uAP_1774070572;
Received: from 30.42.98.36(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.O-uAP_1774070572 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 13:22:53 +0800
Message-ID: <a9c48aca-fd2b-4b01-95d2-62607594d236@linux.alibaba.com>
Date: Sat, 21 Mar 2026 13:22:52 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm: change to return bool for
 ptep_test_and_clear_young()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
 <ikarxctf.ritesh.list@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ikarxctf.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/26 1:57 PM, Ritesh Harjani (IBM) wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Callers use ptep_test_and_clear_young() to clear the young flag and check
>> whether it was set. Change the return type to bool to make the intention
>> clearer.
>>
> 
> Right I checked all callers of ptep_test_and_clear_young(). I agree, we
> only need bool here.
> 
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h             |  8 ++++----
>>   arch/arm64/mm/contpte.c                      |  4 ++--
>>   arch/microblaze/include/asm/pgtable.h        |  2 +-
>>   arch/parisc/include/asm/pgtable.h            |  6 +++---
>>   arch/powerpc/include/asm/book3s/32/pgtable.h |  4 ++--
>>   arch/powerpc/include/asm/book3s/64/pgtable.h |  6 +++---
>>   arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++--
> 
> I looked at it because of powerpc changes, but ended up looking into all
> call sites anyways. So overall it LGTM (and I agree that we can remove
> the unnecessary externs from function declarations)
> 
> With that please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for reviewing. Will remove externs:)
