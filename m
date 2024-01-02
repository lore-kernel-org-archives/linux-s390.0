Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698E468C;
	Tue,  2 Jan 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vzo3gpK_1704183190;
Received: from 30.221.130.246(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vzo3gpK_1704183190)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 16:13:11 +0800
Message-ID: <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>
Date: Tue, 2 Jan 2024 16:13:09 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] net/smc: Adjustments for two function implementations
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/31 22:55, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 15:48:45 +0100
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>    Return directly after a failed kzalloc() in smc_fill_gid_list()
>    Improve exception handling in smc_llc_cli_add_link_invite()
> 
>   net/smc/af_smc.c  |  2 +-
>   net/smc/smc_llc.c | 15 +++++++--------
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> --
> 2.43.0

Hi Markus. I see you want to fix the kfree(NULL) issues in these two patches.

But I am wondering if this is necessary, since kfree() can handle NULL correctly.

/**
  * kfree - free previously allocated memory
  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
  *
  * If @object is NULL, no operation is performed.
  */
void kfree(const void *object)
{
         struct folio *folio;
         struct slab *slab;
         struct kmem_cache *s;

         trace_kfree(_RET_IP_, object);

         if (unlikely(ZERO_OR_NULL_PTR(object)))
                 return;

         folio = virt_to_folio(object);
         if (unlikely(!folio_test_slab(folio))) {
                 free_large_kmalloc(folio, (void *)object);
                 return;
         }

         slab = folio_slab(folio);
         s = slab->slab_cache;
         __kmem_cache_free(s, (void *)object, _RET_IP_);
}
EXPORT_SYMBOL(kfree);


Thanks,
Wen Gu
