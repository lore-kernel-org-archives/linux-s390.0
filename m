Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7BD1734;
	Thu,  7 Dec 2023 17:45:09 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy1KmNN_1701999905;
Received: from 30.221.129.118(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy1KmNN_1701999905)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 09:45:06 +0800
Message-ID: <f86b04c6-a9ff-2ae7-f131-6dd870d454b1@linux.alibaba.com>
Date: Fri, 8 Dec 2023 09:45:05 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] MAINTAINERS: remove myself as maintainer of SMC
To: Karsten Graul <kgraul@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Stefan Raspl
 <raspl@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
 Niklas Schnell <schnelle@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>
References: <20231207202358.53502-1-wenjia@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231207202358.53502-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/8 04:23, Wenjia Zhang wrote:
> From: Karsten Graul <kgraul@linux.ibm.com>
> 
> I changed responsibilities some time ago, its time
> to remove myself as maintainer of the SMC component.
> 

Thank you Karsten for your contributions and efforts to SMC component. :)

> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e6109201e8b4..ddb858576d8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19638,7 +19638,6 @@ S:	Maintained
>   F:	drivers/misc/sgi-xp/
>   
>   SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
> -M:	Karsten Graul <kgraul@linux.ibm.com>
>   M:	Wenjia Zhang <wenjia@linux.ibm.com>
>   M:	Jan Karcher <jaka@linux.ibm.com>
>   R:	D. Wythe <alibuda@linux.alibaba.com>
