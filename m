From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 02/12] s390: Lowcore mapping helper.
Date: Fri, 18 Jan 2013 17:54:33 +0100
Message-ID: <FACC7822-C6C1-4F21-B7E6-62DD829FD9D0@suse.de>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com> <1358432637-42512-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-3-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 17.01.2013, at 15:23, Cornelia Huck wrote:

> Create a lowcore mapping helper that includes a check for sufficient
> length.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> target-s390x/helper.c | 31 +++++++++++++++++++++++++------
> 1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/target-s390x/helper.c b/target-s390x/helper.c
> index 9a132e6..bf2b4d3 100644
> --- a/target-s390x/helper.c
> +++ b/target-s390x/helper.c
> @@ -471,13 +471,32 @@ static uint64_t get_psw_mask(CPUS390XState *env)
>     return r;
> }
> 
> +static LowCore *cpu_map_lowcore(CPUS390XState *env, hwaddr *len)

Just declare len to PAGE_SIZE * 2, like you do in kvm. Or to sizeof(LowCore). Then don't pass it in as parameter, but basically guarantee that the function always returns a full LowCore struct.

> +{
> +    LowCore *lowcore;
> +
> +    if (*len < sizeof(LowCore)) {
> +        cpu_abort(env, "Insufficient length %d for mapping lowcore\n",
> +                  (int) *len);
> +    }
> +
> +    lowcore = cpu_physical_memory_map(env->psa, len, 1);

Here is the place where the size check should be really :).


Alex
