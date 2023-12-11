Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B855107;
	Mon, 11 Dec 2023 02:09:51 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyFRZUV_1702289387;
Received: from 30.221.130.53(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyFRZUV_1702289387)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 18:09:49 +0800
Message-ID: <1c14f769-8da2-fdac-cec2-a59ab69284ad@linux.alibaba.com>
Date: Mon, 11 Dec 2023 18:09:45 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 7/9] net/smc: support extended GID in SMC-D
 lgr netlink attribute
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
 <1702021259-41504-8-git-send-email-guwen@linux.alibaba.com>
 <8b651c68-c51d-49a9-9df0-58e9110fa47d@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <8b651c68-c51d-49a9-9df0-58e9110fa47d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/11 17:39, Alexandra Winter wrote:
> 
> 
> On 08.12.23 08:40, Wen Gu wrote:
>> Virtual ISM devices introduced in SMCv2.1 requires a 128 bit extended
>> GID vs. the existing ISM 64bit GID. So the 2nd 64 bit of extended GID
>> should be included in SMC-D linkgroup netlink attribute as well.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> 
> This patch did not apply cleanly.
> Please always base patches on the current net-next

Strange.. I can apply them cleanly with the latest net-next
(6e944cc68633 ("Merge branch 'rswitch-jumbo-frames'")).

Could you please try again? Thanks.
