From: Harald Freudenberger <freude@linux.ibm.com>
Date: Tue, 26 Jun 2018 07:25:42 +0000
Subject: Re: potential bufferovflows in drivers/s390/crypto/
Message-Id: <41c73b2c-7030-a908-6e9f-fa06f7af8a03@linux.ibm.com>
In-Reply-To: <20180626072220.GG4299@osiris>
References: <20180626072220.GG4299@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 26.06.2018 09:22, Heiko Carstens wrote:
> On Tue, Jun 26, 2018 at 09:37:01AM +0300, Georgi Guninski wrote:
>> On Tue, Jun 26, 2018 at 08:05:47AM +0200, Heiko Carstens wrote:
>>> This is actually already the third time that somebody reports a potential
>>> buffer overflow for this function. Could you please add a comment in the
>>> code to avoid future confusion?
>> This also confuses static analyzers and they don't read comments.
>> In one of the functions (alive in kernel 3.20) adding check is possible.
> Adding an extra, but superfluous, check would be fine with me as
> well. Given that it is obviously non-trivial to tell that this code isn't
> broken.
I'll add checks and comments. However, I will not do any backports for older kernels.
