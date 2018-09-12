From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 12 Sep 2018 14:47:15 +0000
Subject: Re: [PATCH 1/2 v2] s390: qeth: Fix potential array overrun in cmd/rc lookup
Message-Id: <4b8c9e01-6ed1-dcc4-7e64-494726a3b746@linux.ibm.com>
In-Reply-To: <20180910165233.377f3cae@endymion>
References: <20180910165233.377f3cae@endymion>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 10.09.2018 16:52, Jean Delvare wrote:
> Functions qeth_get_ipa_msg and qeth_get_ipa_cmd_name are modifying
> the last member of global arrays without any locking that I can see.
> If two instances of either function are running at the same time,
> it could cause a race ultimately leading to an array overrun (the
> contents of the last entry of the array is the only guarantee that
> the loop will ever stop).
> 
> Performing the lookups without modifying the arrays is admittedly
> slower (two comparisons per iteration instead of one) but these
> are operations which are rare (should only be needed in error
> cases or when debugging, not during successful operation) and it
> seems still less costly than introducing a mutex to protect the
> arrays in question.
> 
> As a side bonus, it allows us to declare both arrays as const data.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Julian Wiedmann <jwi@linux.ibm.com>
> Cc: Ursula Braun <ubraun@linux.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> Note: build-tested only.
> Note: applies on top of zhong jiang's patch which makes use of
> ARRAY_SIZE.
> 
> Changes since v1:
>  * Restored last entry of qeth_ipa_cmd_names[], which had been removed
>    by accident. Reported by Ursula Braun.
> 
>  drivers/s390/net/qeth_core_main.c |    2 +-
>  drivers/s390/net/qeth_core_mpc.c  |   30 ++++++++++++++++--------------
>  drivers/s390/net/qeth_core_mpc.h  |    4 ++--
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 

Looks good - applied, thanks Jean!
