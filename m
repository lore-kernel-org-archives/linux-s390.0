Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE4FD;
	Mon, 11 Dec 2023 00:41:07 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyEGLG4_1702284064;
Received: from 30.221.130.53(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyEGLG4_1702284064)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 16:41:05 +0800
Message-ID: <dce514ab-5650-2b6c-9326-fd313bb44622@linux.alibaba.com>
Date: Mon, 11 Dec 2023 16:41:03 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 5/9] net/smc: define a reserved CHID range for
 virtual ISM devices
To: Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-6-git-send-email-guwen@linux.alibaba.com>
 <5094518a-1d60-48fb-aaf2-dd811296e53a@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <5094518a-1d60-48fb-aaf2-dd811296e53a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/11 16:24, Alexandra Winter wrote:
> 
> 
> On 08.12.23 08:40, Wen Gu wrote:
>> According to virtual ISM support feature defined by SMCv2.1, CHIDs in
>> the range 0xFF00 to 0xFFFF are reserved for use by virtual ISM devices.
>>
>> And two helpers are introduced to distinguish virtual ISM devices from
>> the existing platform firmware ISM devices.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> 
> I've sent you a Reviewed-by for v3 of this patch. Did you lose it?

Sorry! I missed it when formating the patches.
I will add your and Wenjia's Reviewed-by to the unmodified patches, thank you!
New version coming soon.
