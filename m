Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E60D95;
	Wed, 13 Dec 2023 05:38:52 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VyRHh03_1702474728;
Received: from 30.221.129.237(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyRHh03_1702474728)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 21:38:50 +0800
Message-ID: <7cc939cf-d63f-41fc-8048-893a57ac4ab1@linux.alibaba.com>
Date: Wed, 13 Dec 2023 21:38:48 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: SMC-R throughput drops for specific message sizes
To: Gerd Bayer <gbayer@linux.ibm.com>,
 "Nikolaou Alexandros (SO/PAF1-Mb)" <Alexandros.Nikolaou@de.bosch.com>,
 "D . Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Nils Hoppmann <niho@linux.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
References: <PAWPR10MB72701758A24DD8DF8063BEE6C081A@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
 <ccc03f00-02ee-4af6-8e57-b6de3bc019be@linux.ibm.com>
 <PAWPR10MB7270731C91544AEF25E0A33CC084A@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
 <2c460a84c6e725187dda05fc553981ce3022bb78.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <2c460a84c6e725187dda05fc553981ce3022bb78.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/12/13 20:17, Gerd Bayer wrote:
> Hi Nikolaou,
> 
> thank you for providing more details about your setup.
> 
> On Wed, 2023-12-06 at 15:28 +0000, Nikolaou Alexandros (SO/PAF1-Mb)
> wrote:
>> Dear Wenjia,
> 
> while Wenjia is out, I'm writing primarily to getting some more folks'
> attention to this topic. Furthermore, I'm moving the discussion to the
> netdev mailing list where SMC discussions usually take place.
> 
>> Thanks for getting back to me. Some further details on the
>> experiments are:
>>   
>> - The tests had been conducted on a one-to-one connection between two
>> Mellanox-powered (mlx5, ConnectX-5) PCs.
>> - Attached you may find the client log of the qperf output. You may
>> notice that for the majority of message size values, the bandwidth is
>> around 3.2GB/s which matches the maximum throughput of the
>> mellanox NICs.
>> According to a periodic regular pattern though, with the first
>> occurring at a message size of 473616 – 522192 (with a step of
>> 12144kB), the 3.2GB/s throughput drops substantially. The
>> corresponding commands for these drops are
>> server: smc_run qperf
>> client: smc_run qperf -v -uu -H worker1 -m 473616 tcp_bw
>> - Our smc version (3E92E1460DA96BE2B2DDC2F, smc-tools-1.2.2) does not
>> provide us with the smcr info, smc_rnics -a and smcr -d
>> stats commands. As an alternative, you may also find attached the
>> output of ibv_devinfo -v.
>> - Buffer size:
>> sudo sysctl -w net.ipv4.tcp_rmem="4096 1048576 6291456"
>> sudo sysctl -w net.ipv4.tcp_wmem="4096 1048576 6291456"
>> - MTU size: 9000
>>   
>> Should you require further information, please let me know.
> 
> Wenjia and I belong to a group of Linux on Z developers that maintains
> the SMC protocol on s390 mainframe systems. Nils Hoppmann is our expert
> for performance and might be able to shed some light on his experiences
> with throughput drops for particular SMC message sizes. Our experience
> is heavily biased towards IBM Z systems, though - with their distinct
> cache and PCI root-complex hardware designs.
> 
> Over the last few years there's a group around D. Wythe, Wen Gu and
> Tony Lu who adopted and extended the SMC protocol for use-cases on x86
> architectures. I address them here explicitly, soliciting feedback on
> their experiences.

Certainly. Our team will take a closer look into this matter as well.
We intend to review the thread thoroughly and conduct an analysis within
our environment. Updates and feedback will be provided in this thread.

> 
> All in all there are several moving parts involved here, that could
> play a role:
> - firmware level of your Mellanox/NVidia NICs,
> - platform specific hardware designs re. cache and root-complexes,
> interrupt distribution, ...
> - exact code level of the device drivers and the SMC protocol
> 
> This is just a heads-up, that there may be requests to try things with
> newer code levels ;)
> 
> Thank you,
> Gerd
> 
> --
> Gerd Bayer
> Linux on IBM Z Development - IBM Germany R&D
