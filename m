From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 23 Jul 2013 23:53:07 +0000
Subject: Re: [PATCH] s390: Kconfig: select 'TTY' when 'S390_GUEST' enabled.
Message-Id: <51EF1763.3020904@asianux.com>
In-Reply-To: <20130723104703.GB26775@osiris>
References: <20130723104703.GB26775@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/23/2013 06:47 PM, Heiko Carstens wrote:
> On Tue, Jul 23, 2013 at 04:26:08PM +0800, Chen Gang wrote:
>> 'VIRTIO_CONSOLE' depends on 'TTY', so need select 'TTY' explicitly
>> before select 'VIRTIO_CONSOLE'.
>>
>> Or randconfig can generate a config file which enable 'VIRTIO_CONSOLE'
>> but disable 'TTY' (e.g. the attachment).
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/s390/Kconfig |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> Applied, thanks.
> 
> 
> 

Thank you very much.

-- 
Chen Gang
