From: Syam Sidhardhan <syamsidhardh@gmail.com>
Date: Wed, 06 Mar 2013 19:49:56 +0000
Subject: Re: [PATCH] s390: Remove redundant NULL check before kfree
Message-Id: <CAFBvHiegNZk=_nG9bJqHPoGSe4vnniotEBMWh3ze-XW9Kqz9Vg@mail.gmail.com>
In-Reply-To: <20130306102415.GA4031@osiris>
References: <20130306102415.GA4031@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko,

On Wed, Mar 6, 2013 at 3:54 PM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Wed, Mar 06, 2013 at 12:53:48AM +0530, Syam Sidhardhan wrote:
>> kfree on NULL pointer is a no-op.
>>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>
> Thanks, however I'd prefer if your email address (== From:) would be
> the same as your Signed-of-by: email address. Can you fix that please?
>

Thanks a lot to point out this mistake. I'll send a fixed version.

BR,
Syam.
