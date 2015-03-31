From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 12/15] Add optional parameters to QMP
 command query-cpu-definitions
Date: Tue, 31 Mar 2015 16:46:56 -0300
Message-ID: <20150331194656.GK7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-13-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <1427725708-52100-13-git-send-email-mimu@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 30, 2015 at 04:28:25PM +0200, Michael Mueller wrote:
[...]
>  ##
>  # @query-cpu-definitions:
>  #
>  # Return a list of supported virtual CPU definitions
>  #
> +# @machine: #optional machine type (since 2.4)
> +#
> +# @accel: #optional accelerator id (since 2.4)
> +#
>  # Returns: a list of CpuDefInfo
>  #
>  # Since: 1.2.0
>  ##
> -{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
> +{ 'command': 'query-cpu-definitions',
> +  'data': { '*machine': 'str', '*accel': 'AccelId' },
> +  'returns': ['CpuDefinitionInfo'] }

What happens if the new parameters are provided to an old QEMU version
that doesn't accept them? It looks like we need an introspection
mechanism or a new command name.

-- 
Eduardo
