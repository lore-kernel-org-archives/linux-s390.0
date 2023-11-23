Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D3A1;
	Thu, 23 Nov 2023 05:16:45 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vwzd6KE_1700745401;
Received: from 30.221.129.10(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vwzd6KE_1700745401)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 21:16:43 +0800
Message-ID: <24ea5034-78ef-c173-3739-fb05418f8d11@linux.alibaba.com>
Date: Thu, 23 Nov 2023 21:16:39 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 5/7] net/smc: compatible with 128-bits extend GID
 of virtual ISM device
To: Jakub Kicinski <kuba@kernel.org>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
 <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>
 <20231120111739.31baf90a@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231120111739.31baf90a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/11/21 03:17, Jakub Kicinski wrote:
> On Sun, 19 Nov 2023 21:57:55 +0800 Wen Gu wrote:
>> According to virtual ISM support feature defined by SMCv2.1, GIDs of
>> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
>> long. So some adaptation work is required. And note that the GIDs of
>> existing platform firmware ISM devices still remain 64-bits long.
> 
> sparse (C=1 build) complains:
> 
> net/smc/smc_clc.c:944:73: warning: incorrect type in argument 1 (different base types)
> net/smc/smc_clc.c:944:73:    expected unsigned short [usertype] chid
> net/smc/smc_clc.c:944:73:    got restricted __be16 [usertype] chid

It will be fixed in the next version. Thank you very much!

Thanks,
Wen Gu
