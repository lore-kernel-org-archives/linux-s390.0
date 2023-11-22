Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB0A93;
	Wed, 22 Nov 2023 01:53:44 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VwvWZ-S_1700646821;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VwvWZ-S_1700646821)
          by smtp.aliyun-inc.com;
          Wed, 22 Nov 2023 17:53:42 +0800
Date: Wed, 22 Nov 2023 17:53:41 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Li RongQing <lirongqing@baidu.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Message-ID: <20231122095341.GG3323@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231117111657.16266-1-lirongqing@baidu.com>
 <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
 <20231120032029.GA3323@linux.alibaba.com>
 <22394c7b-0470-472d-9474-4de5fc86c5ea@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22394c7b-0470-472d-9474-4de5fc86c5ea@linux.ibm.com>

On Mon, Nov 20, 2023 at 10:11:17AM +0100, Alexandra Winter wrote:
>
>
>On 20.11.23 04:20, Dust Li wrote:
>>> It seems to me that the purpose of conn->tx_pushing is
>>> a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
>>> b) Repeat, in case some other thread has added data to sndbuf concurrently.
>>>
>>> I agree that this patch does not change the behaviour of this function and removes an
>>> atomic_set() in the likely path.
>>>
>>> I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
>>> So how can we ever run in a concurrency situation?
>>> Is this handling of conn->tx_pushing necessary at all?
>> Hi Sandy,
>> 
>> Overall, I think you are right. But there is something we need to take care.
>> 
>> Before commit 6b88af839d20 ("net/smc: don't send in the BH context if
>> sock_owned_by_user"), we used to call smc_tx_pending() in the soft IRQ,
>> without checking sock_owned_by_user(), which would caused a race condition
>> because bh_lock_sock() did not honor sock_lock(). To address this issue,
>> I have added the tx_pushing mechanism. However, with commit 6b88af839d20,
>> we now defer the transmission if sock_lock() is held by the user.
>> Therefore, there should no longer be a race condition. Nevertheless, if
>> we remove the tx_pending mechanism, we must always remember not to call
>> smc_tx_sndbuf_nonempty() in the soft IRQ when the user holds the sock lock.
>> 
>> Thanks
>> Dust
>
>
>ok, I understand.
>So whoever is willing to give it a try and simplify smc_tx_sndbuf_nonempty(),
>should remember to document that requirement/precondition.
>Maybe in a Function context section of a kernel-doc function decription?
>(as described in https://docs.kernel.org/doc-guide/kernel-doc.html)
>Although smc_tx_sndbuf_nonempty() is not exported, this format is helpful.

I double checked this and realized that I may have missed something
previously. The original goal of introducing tx_push was to maximize the
amount of data that could be corked in order to achieve the best
performance.

__smc_tx_sndbuf_nonempty() is thread and context safe, meaning that
it can be called simultaneously in both user context and softirq without
causing any bugs, just some CPU waste. Although I think we should remove
all the atomics & locks in the data path and only use sock_lock in the
long-term.

I will collaborate with Li RongQing on a new version that eliminates the
tx_pushing.

Best regards,
Dust
